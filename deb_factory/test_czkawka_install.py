"""Exercise the real maintainer scripts in a temporary installation root."""

import hashlib
import json
import os
from pathlib import Path
import shlex
import shutil
import signal
import subprocess
import sys
import tempfile
import unittest


TEMPLATE = Path(__file__).resolve().parent / "template_build_arm64"
INSTALLER = Path("opt/dslideshow/scripts/install_czkawka.sh")
TARGET = Path("opt/dslideshow/bin/czkawka_cli")
LINK = Path("usr/local/bin/czkawka_cli")
UPSTREAM_SHA256 = "3a65408ca30036cf1cd993112bde6288e13c870842d12131dee8b4e435325c38"
URL = "https://github.com/qarmin/czkawka/releases/download/12.0.2/linux_czkawka_cli_arm64"


class CzkawkaInstallTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory(prefix="czkawka install ")
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.install_root = self.root / "system"
        shutil.copytree(TEMPLATE, self.install_root)
        self.bin = self.root / "commands"
        self.bin.mkdir()
        self.commands = self.root / "commands.jsonl"
        self.asset = self.root / "asset"
        self.asset.write_text(
            '#!/bin/sh\n[ "$#" -eq 1 ] && [ "$1" = --version ] || exit 99\n'
            'printf "czkawka_cli 12.0.2\\n"\nexit "${TEST_RUNTIME_STATUS:-0}"\n'
        )
        source = (TEMPLATE / INSTALLER).read_text()
        self.assertEqual(source.count(UPSTREAM_SHA256), 1)
        # Only replace the release payload digest with that of an executable
        # fixture. sha256sum, timeout, filesystem operations and scripts are real.
        (self.install_root / INSTALLER).write_text(source.replace(
            UPSTREAM_SHA256, hashlib.sha256(self.asset.read_bytes()).hexdigest()
        ))
        for name in ("curl", "logger", "sudo"):
            executable = self.bin / name
            executable.write_text(f"#!{sys.executable}\n" + """
import json, os, pathlib, signal, sys
name = pathlib.Path(sys.argv[0]).name
args = sys.argv[1:]
with open(os.environ['TEST_COMMANDS'], 'a') as log:
    log.write(json.dumps([name, args]) + '\\n')
if name == 'curl':
    out = pathlib.Path(args[args.index('--output') + 1])
    out.write_bytes(pathlib.Path(os.environ['TEST_ASSET']).read_bytes())
    if os.environ.get('TEST_CANCEL'):
        os.kill(os.getppid(), signal.SIGTERM)
    sys.exit(int(os.environ.get('TEST_CURL_STATUS', '0')))
if name == 'logger':
    print(args[-1], file=sys.stderr)
""")
            executable.chmod(0o755)
        self.env = dict(
            os.environ,
            PATH=f"{self.bin}{os.pathsep}{os.environ['PATH']}",
            DPKG_ROOT=str(self.install_root),
            TEST_COMMANDS=str(self.commands),
            TEST_ASSET=str(self.asset),
        )

    def run_script(self, relative=INSTALLER, *args):
        return subprocess.run(
            [str(self.install_root / relative), *args],
            env=self.env, capture_output=True, text=True, timeout=10,
        )

    def calls(self, name):
        if not self.commands.exists():
            return []
        return [args for tool, args in (
            json.loads(line) for line in self.commands.read_text().splitlines()
        ) if tool == name]

    def assert_no_temporary_files(self):
        self.assertEqual(list((self.install_root / TARGET.parent).glob('.czkawka-install.*')), [])

    def assert_log(self, result, message):
        self.assertIn(message, result.stderr)
        records = [args for args in self.calls('logger') if message in args[-1]]
        self.assertTrue(records)
        for args in records:
            self.assertIn('component=czkawka-install', args[-1])
            self.assertIn('operation=', args[-1])
            self.assertEqual(args[args.index('-p') + 1],
                             'syslog.err' if 'result=failed' in message else 'syslog.info')

    def test_configure_downloads_pinned_release_and_exposes_service_command(self):
        result = self.run_script(Path('DEBIAN/postinst'), 'configure')
        self.assertEqual(result.returncode, 0, result.stderr)
        target = self.install_root / TARGET
        self.assertEqual(target.read_bytes(), self.asset.read_bytes())
        self.assertEqual(target.stat().st_mode & 0o777, 0o755)
        self.assertEqual(target.parent.stat().st_mode & 0o777, 0o755)
        self.assertEqual((self.install_root / LINK).resolve(), target)
        curl, = self.calls('curl')
        self.assertEqual(curl[-1], URL)
        for flag in ('--fail', '--location', '--connect-timeout', '--max-time', '--retry'):
            self.assertIn(flag, curl)
        self.assertEqual(curl[curl.index('--proto') + 1], '=https')
        self.assertEqual(curl[curl.index('--proto-redir') + 1], '=https')
        service = (TEMPLATE / 'etc/systemd/system/dslideshow.service').read_text()
        environment = next(line for line in service.splitlines() if line.startswith('Environment='))
        service_path = shlex.split(environment.removeprefix('Environment='))[0].removeprefix('PATH=')
        for path in (service_path, '/usr/local/bin:/usr/bin:/bin'):
            with self.subTest(path=path):
                # Relocate the service's real PATH into the temporary root.
                relocated = ':'.join(str(self.install_root / part.lstrip('/')) for part in path.split(':'))
                command = subprocess.run(
                    ['/bin/sh', '-c', 'command -v czkawka_cli; czkawka_cli --version'],
                    env=dict(self.env, PATH=relocated), capture_output=True, text=True, timeout=5,
                )
                self.assertEqual(command.returncode, 0, command.stderr)
                self.assertIn('czkawka_cli 12.0.2', command.stdout)
        self.assert_log(result, 'action=install result=completed')
        self.assert_no_temporary_files()

    def test_verified_install_is_reused_offline_and_missing_link_is_restored(self):
        first = self.run_script()
        self.assertEqual(first.returncode, 0, first.stderr)
        (self.install_root / LINK).unlink()
        (self.install_root / TARGET).chmod(0o600)
        self.env['TEST_CURL_STATUS'] = '22'
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(len(self.calls('curl')), 1)
        self.assertEqual((self.install_root / LINK).resolve(), self.install_root / TARGET)
        self.assertEqual((self.install_root / TARGET).stat().st_mode & 0o777, 0o755)
        self.assert_log(result, 'action=reuse result=verified')

    def test_corrupt_installed_binary_is_replaced(self):
        target = self.install_root / TARGET
        target.parent.mkdir()
        target.write_text('corrupt previous binary')
        target.chmod(0o755)
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(target.read_bytes(), self.asset.read_bytes())
        self.assertEqual(len(self.calls('curl')), 1)

    def test_download_checksum_runtime_and_cancel_failures_preserve_old_binary(self):
        for failure, stage, status in (
            ('network', 'download', 22), ('checksum', 'checksum', 1),
            ('runtime', 'runtime', 127), ('cancel', 'download', 143),
        ):
            with self.subTest(failure=failure):
                target = self.install_root / TARGET
                target.parent.mkdir(exist_ok=True)
                target.write_bytes(b'previous working version')
                target.chmod(0o755)
                self.env['TEST_CURL_STATUS'] = '22' if failure == 'network' else '0'
                self.env['TEST_RUNTIME_STATUS'] = '127' if failure == 'runtime' else '0'
                self.env['TEST_CANCEL'] = '1' if failure == 'cancel' else ''
                original_asset = self.asset.read_bytes()
                if failure == 'checksum':
                    self.asset.write_bytes(b'invalid response')
                result = self.run_script(Path('DEBIAN/postinst'), 'configure')
                self.asset.write_bytes(original_asset)
                self.assertEqual(result.returncode, status, result.stderr)
                self.assertEqual(target.read_bytes(), b'previous working version')
                self.assertFalse((self.install_root / LINK).is_symlink())
                outcome = 'cancelled' if failure == 'cancel' else 'failed'
                self.assert_log(result, f'action={stage} result={outcome}')
                self.assertEqual(self.calls('sudo'), [], 'failed configure must not enable the service')
                self.assert_no_temporary_files()

    def test_existing_unmanaged_command_is_preserved(self):
        link = self.install_root / LINK
        link.parent.mkdir(parents=True)
        for kind in ('file', 'symlink'):
            with self.subTest(kind=kind):
                if kind == 'file':
                    link.write_text('administrator command')
                else:
                    link.symlink_to('/administrator/missing/command')
                result = self.run_script()
                self.assertNotEqual(result.returncode, 0)
                self.assert_log(result, 'action=link-conflict result=failed')
                self.assertEqual(self.calls('curl'), [])
                if kind == 'file':
                    self.assertEqual(link.read_text(), 'administrator command')
                else:
                    self.assertEqual(os.readlink(link), '/administrator/missing/command')
                link.unlink()

    def test_recovery_does_not_run_install_or_change_system_configuration(self):
        result = self.run_script(Path('DEBIAN/postinst'), 'abort-upgrade')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse(self.commands.exists())

    def test_upgrade_keeps_cli_and_removal_cleans_only_owned_files(self):
        result = self.run_script()
        self.assertEqual(result.returncode, 0, result.stderr)
        result = self.run_script(Path('DEBIAN/postrm'), 'upgrade', 'next-version')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.install_root / LINK).exists())
        unrelated = self.install_root / TARGET.parent / 'administrator-tool'
        unrelated.write_text('keep')
        result = self.run_script(Path('DEBIAN/postrm'), 'remove')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse((self.install_root / LINK).is_symlink())
        self.assertFalse((self.install_root / TARGET).exists())
        self.assertEqual(unrelated.read_text(), 'keep')
        self.assert_log(result, 'action=remove result=completed')
        # A subsequent purge must not remove a replacement command.
        (self.install_root / LINK).symlink_to('/administrator/other-tool')
        result = self.run_script(Path('DEBIAN/postrm'), 'purge')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(os.readlink(self.install_root / LINK), '/administrator/other-tool')


if __name__ == '__main__':
    unittest.main()
