"""Check the installed sensor script against an isolated sysfs fixture."""

import errno
import os
from pathlib import Path
import subprocess
import tempfile
import time
import unittest


SCRIPT = (
    Path(__file__).resolve().parent
    / "template_build_arm64/opt/dslideshow/scripts/sensorsScript.sh"
)
TEMPERATURE = "temp=57.1'C\n"


class SensorsScriptTest(unittest.TestCase):
    def setUp(self):
        # Spaces also exercise quoting of the configurable sysfs root.
        self.directory = tempfile.TemporaryDirectory(prefix="sensors fixture ")
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.sysfs = self.root / "sys"
        self.bin = self.root / "bin"
        self.bin.mkdir()
        self.command = self.bin / "vcgencmd"
        self.command.write_text(
            "#!/bin/sh\n"
            '[ "$#" -eq 1 ] && [ "$1" = measure_temp ] || exit 99\n'
            'printf \'%s\' "$MOCK_TEMPERATURE"\n'
            'printf \'%s\' "$MOCK_TEMPERATURE_ERROR" >&2\n'
            'exit "$MOCK_TEMPERATURE_STATUS"\n'
        )
        self.command.chmod(0o755)
        self.env = dict(
            os.environ,
            DSLIDESHOW_SYSFS_ROOT=str(self.sysfs),
            PATH=str(self.bin),
            MOCK_TEMPERATURE=TEMPERATURE,
            MOCK_TEMPERATURE_ERROR="",
            MOCK_TEMPERATURE_STATUS="0",
        )

    def hwmon(self, number="2", *, name="pwmfan\n", rpm="4611\n", board=True):
        platform = "cooling_fan" if board else "another_fan"
        device = self.sysfs / "devices/platform" / platform / "hwmon" / f"hwmon{number}"
        device.mkdir(parents=True)
        (device / "name").write_text(name)
        if rpm is not None:
            (device / "fan1_input").write_text(rpm)
        return device

    def run_script(self):
        return subprocess.run(
            ["/bin/sh", str(SCRIPT)],
            env=self.env,
            text=True,
            capture_output=True,
            timeout=5,
        )

    def assert_measurements(self, result, output, *, status=0, diagnostic=False):
        self.assertEqual(result.returncode, status, result.stderr)
        self.assertEqual(result.stdout, output)
        if diagnostic:
            self.assertTrue(result.stderr.strip(), "missing sensor failure diagnostic")
        else:
            self.assertEqual(result.stderr, "")

    def run_with_fifo(self, fifo, on_open):
        """Synchronize fixture mutation with a real attribute read, without hooks."""
        with subprocess.Popen(
            ["/bin/sh", str(SCRIPT)],
            env=self.env,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        ) as process:
            deadline = time.monotonic() + 5
            try:
                while True:
                    try:
                        descriptor = os.open(fifo, os.O_WRONLY | os.O_NONBLOCK)
                        break
                    except OSError as error:
                        if error.errno != errno.ENXIO:
                            raise
                        if process.poll() is not None or time.monotonic() >= deadline:
                            self.fail("script did not open the fixture attribute")
                        time.sleep(0.01)
                try:
                    on_open(descriptor)
                finally:
                    os.close(descriptor)
                stdout, stderr = process.communicate(timeout=5)
                return subprocess.CompletedProcess(
                    process.args, process.returncode, stdout, stderr
                )
            finally:
                if process.poll() is None:
                    process.kill()
                    process.communicate()

    def test_reads_real_rpm_and_preserves_zero(self):
        for value in ("4611", "0", "0000", "18446744073709551616"):
            with self.subTest(value=value):
                device = self.hwmon(value, rpm=value + "\n")
                try:
                    self.assert_measurements(
                        self.run_script(), TEMPERATURE + f"fan1={value}rpm\n"
                    )
                finally:
                    (device / "name").unlink()
                    (device / "fan1_input").unlink()
                    device.rmdir()

    def test_accepts_rpm_without_final_newline(self):
        self.hwmon(name="pwmfan", rpm="1280")
        self.assert_measurements(self.run_script(), TEMPERATURE + "fan1=1280rpm\n")

    def test_absent_board_fan_is_optional(self):
        self.assert_measurements(self.run_script(), TEMPERATURE)

    def test_absent_fan_attribute_is_optional(self):
        self.hwmon(rpm=None)
        self.assert_measurements(self.run_script(), TEMPERATURE)

    def test_hwmon_number_can_change(self):
        self.hwmon("137", rpm="2050\n")
        self.assert_measurements(self.run_script(), TEMPERATURE + "fan1=2050rpm\n")

    def test_only_board_pwmfan_is_selected(self):
        self.hwmon("1", name="unrelated\n", rpm="9999\n")
        self.hwmon("91", rpm="2050\n")
        self.hwmon("2", rpm="1234\n", board=False)
        foreign = self.sysfs / "class/hwmon/hwmon0"
        foreign.mkdir(parents=True)
        (foreign / "name").write_text("pwmfan\n")
        (foreign / "fan1_input").write_text("8888\n")
        self.assert_measurements(self.run_script(), TEMPERATURE + "fan1=2050rpm\n")

    def test_pwmfan_on_other_hardware_does_not_create_board_measurement(self):
        self.hwmon(rpm="1234\n", board=False)
        self.assert_measurements(self.run_script(), TEMPERATURE)

    def test_ambiguous_board_fan_is_not_chosen_arbitrarily(self):
        self.hwmon("1", rpm="1234\n")
        self.hwmon("7", rpm="5678\n")
        self.assert_measurements(self.run_script(), TEMPERATURE, diagnostic=True)

    def test_ambiguous_name_is_rejected_even_when_one_input_is_absent(self):
        self.hwmon("1", rpm="1234\n")
        self.hwmon("7", rpm=None)
        self.assert_measurements(self.run_script(), TEMPERATURE, diagnostic=True)

    def test_invalid_rpm_does_not_turn_into_zero(self):
        device = self.hwmon()
        for value in ("", "\n", "abc\n", "-1\n", "+1\n", "1.5\n", "12rpm\n",
                      " 12\n", "12 \n", "12\r\n", "١٢\n", "12\n34\n",
                      "12\n\n", "12\n34"):
            with self.subTest(value=repr(value)):
                (device / "fan1_input").write_text(value)
                self.assert_measurements(self.run_script(), TEMPERATURE, diagnostic=True)

    def test_invalid_hwmon_name_does_not_match(self):
        device = self.hwmon()
        for name in ("pwmfan\nextra\n", "pwmfan\n\n", "", "\n"):
            with self.subTest(name=repr(name)):
                (device / "name").write_text(name)
                result = self.run_script()
                self.assertEqual(result.returncode, 0)
                self.assertEqual(result.stdout, TEMPERATURE)

    def test_unreadable_rpm_is_reported_without_fake_zero(self):
        device = self.hwmon()
        rpm = device / "fan1_input"
        rpm.chmod(0)
        self.addCleanup(rpm.chmod, 0o600)
        if os.access(rpm, os.R_OK):
            self.skipTest("effective user can bypass fixture read permissions")
        self.assert_measurements(self.run_script(), TEMPERATURE, diagnostic=True)

    def test_attribute_open_failure_keeps_other_sensors(self):
        device = self.hwmon(rpm=None)
        (device / "fan1_input").mkdir()
        self.assert_measurements(self.run_script(), TEMPERATURE, diagnostic=True)

    def test_attribute_disappearing_before_open_remains_optional(self):
        device = self.hwmon()
        name = device / "name"
        name.unlink()
        os.mkfifo(name)

        def remove_input(descriptor):
            os.write(descriptor, b"pwmfan\n")
            # The second read of name waits for EOF, so fan1_input disappears
            # after discovery has begun and before the script can inspect it.
            (device / "fan1_input").unlink()

        self.assert_measurements(self.run_with_fifo(name, remove_input), TEMPERATURE)

    def test_attribute_disappearing_during_read_does_not_publish_zero(self):
        device = self.hwmon(rpm=None)
        rpm = device / "fan1_input"
        os.mkfifo(rpm)

        def disappear_without_data(_descriptor):
            # Opening the writer proves the collector already opened its
            # reader. Unlink and EOF then model a vanished empty attribute.
            rpm.unlink()

        self.assert_measurements(
            self.run_with_fifo(rpm, disappear_without_data),
            TEMPERATURE,
            diagnostic=True,
        )

    def test_preserves_arbitrary_sensor_lines_and_success_stderr(self):
        self.env["MOCK_TEMPERATURE"] = TEMPERATURE + "button0=false\nhuman1=detected\n"
        self.env["MOCK_TEMPERATURE_ERROR"] = "fixture warning\n"
        self.hwmon(rpm="2000\n")
        result = self.run_script()
        self.assert_measurements(
            result,
            self.env["MOCK_TEMPERATURE"] + "fan1=2000rpm\n",
            diagnostic=True,
        )
        self.assertIn("fixture warning\n", result.stderr)

    def test_missing_temperature_command_keeps_valid_fan(self):
        self.command.unlink()
        self.hwmon(rpm="0\n")
        self.assert_measurements(self.run_script(), "fan1=0rpm\n", diagnostic=True)

    def test_failed_temperature_output_is_not_published(self):
        self.env["MOCK_TEMPERATURE"] = "temp=999'C\npartial=bad\n"
        self.env["MOCK_TEMPERATURE_STATUS"] = "7"
        self.env["MOCK_TEMPERATURE_ERROR"] = "fixture command failure\n"
        self.hwmon(rpm="2050\n")
        result = self.run_script()
        self.assert_measurements(result, "fan1=2050rpm\n", diagnostic=True)
        self.assertIn("fixture command failure\n", result.stderr)

    def test_empty_temperature_output_keeps_valid_fan(self):
        self.env["MOCK_TEMPERATURE"] = ""
        self.hwmon(rpm="2050\n")
        self.assert_measurements(self.run_script(), "fan1=2050rpm\n", diagnostic=True)

    def test_no_successful_source_returns_failure_and_no_measurement(self):
        command_source = self.command.read_bytes()
        for temperature_failure in ("missing", "failed", "empty"):
            with self.subTest(temperature_failure=temperature_failure):
                if temperature_failure == "missing":
                    self.command.unlink()
                else:
                    self.command.write_bytes(command_source)
                    self.command.chmod(0o755)
                if temperature_failure == "failed":
                    self.env["MOCK_TEMPERATURE_STATUS"] = "4"
                elif temperature_failure == "empty":
                    self.env["MOCK_TEMPERATURE_STATUS"] = "0"
                    self.env["MOCK_TEMPERATURE"] = ""
                self.assert_measurements(
                    self.run_script(), "", status=1, diagnostic=True
                )

    def test_both_failed_sources_do_not_publish_measurements(self):
        self.hwmon(rpm="invalid\n")
        self.env["MOCK_TEMPERATURE_STATUS"] = "4"
        self.assert_measurements(self.run_script(), "", status=1, diagnostic=True)


if __name__ == "__main__":
    unittest.main()
