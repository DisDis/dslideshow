"""Regression checks for pkg-config cache refresh; no system GTK is required."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


PROJECT_ROOT = Path(os.environ.get(
    "DS_LINUX_PROJECT_ROOT", Path(__file__).resolve().parents[1]))
DEPENDENCIES = PROJECT_ROOT.resolve() / "linux/cmake/LinuxDependencies.cmake"


class LinuxDependenciesTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.pc = self.root / "pkgconfig"
        self.pc.mkdir()
        self.build = self.root / "build"
        (self.root / "CMakeLists.txt").write_text(
            'cmake_minimum_required(VERSION 3.13)\n'
            'project(dependency_check LANGUAGES NONE)\n'
            f'include("{DEPENDENCIES}")\n'
            'file(GENERATE OUTPUT "${CMAKE_BINARY_DIR}/includes.txt" '
            'CONTENT "$<TARGET_PROPERTY:PkgConfig::GTK,INTERFACE_INCLUDE_DIRECTORIES>")\n'
        )

    def write_packages(self, include_dir):
        for module in ("gtk+-3.0", "glib-2.0", "gio-2.0"):
            (self.pc / f"{module}.pc").write_text(
                f"Name: {module}\nDescription: test fixture\nVersion: 3.0.0\n"
                f"Cflags: -I{include_dir}\nLibs:\n"
            )

    def configure(self):
        return subprocess.run(
            ["cmake", "-S", str(self.root), "-B", str(self.build)],
            env={**os.environ, "PKG_CONFIG_PATH": "",
                 "PKG_CONFIG_LIBDIR": str(self.pc), "PKG_CONFIG_SYSROOT_DIR": ""},
            text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            check=False,
        )

    def test_missing_package_has_install_instructions(self):
        result = self.configure()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Missing Linux development dependency: gtk+-3.0", result.stdout)
        self.assertIn("libgtk-3-dev", result.stdout)

    def test_broken_package_reports_missing_include(self):
        missing = self.root / "missing-headers"
        self.write_packages(missing)
        result = self.configure()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("pkg-config reports a missing include directory", result.stdout)
        self.assertIn(str(missing), result.stdout)

    def test_reconfigure_discards_removed_cached_include(self):
        old = self.root / "old-headers"
        old.mkdir()
        self.write_packages(old)
        first = self.configure()
        self.assertEqual(first.returncode, 0, first.stdout)
        new = self.root / "new-headers"
        old.rename(new)
        self.write_packages(new)
        second = self.configure()
        self.assertEqual(second.returncode, 0, second.stdout)
        includes = (self.build / "includes.txt").read_text()
        self.assertIn(str(new), includes)
        self.assertNotIn(str(old), includes)


if __name__ == "__main__":
    unittest.main()
