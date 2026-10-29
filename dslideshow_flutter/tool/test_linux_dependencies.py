"""Regression checks for pkg-config cache refresh; no system GTK is required."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


PROJECT_ROOT = Path(os.environ.get(
    "DS_LINUX_PROJECT_ROOT", Path(__file__).resolve().parents[1]))
DEPENDENCIES = PROJECT_ROOT.resolve() / "linux/cmake/LinuxDependencies.cmake"
IS_CONFIG_APP = PROJECT_ROOT.resolve().name == "config_app"


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
            'foreach(prefix mpv epoxy)\n'
            '  if(TARGET PkgConfig::${prefix})\n'
            '    file(GENERATE OUTPUT "${CMAKE_BINARY_DIR}/${prefix}.txt" '
            'CONTENT "$<TARGET_PROPERTY:PkgConfig::${prefix},INTERFACE_INCLUDE_DIRECTORIES>\\n'
            '$<TARGET_PROPERTY:PkgConfig::${prefix},INTERFACE_LINK_LIBRARIES>")\n'
            '  endif()\n'
            'endforeach()\n'
        )

    def write_packages(self, include_dir):
        for module in ("gtk+-3.0", "glib-2.0", "gio-2.0", "mpv", "epoxy"):
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

    @unittest.skipUnless(IS_CONFIG_APP, "video dependencies belong to config_app")
    def test_missing_video_package_has_install_instructions(self):
        headers = self.root / "headers"
        headers.mkdir()
        for module in ("mpv", "epoxy"):
            with self.subTest(module=module):
                self.write_packages(headers)
                (self.pc / f"{module}.pc").unlink()
                result = self.configure()
                self.assertNotEqual(result.returncode, 0, result.stdout)
                self.assertIn(f"Missing Linux development dependency: {module}", result.stdout)
                self.assertIn("libmpv-dev libepoxy-dev", result.stdout)

    @unittest.skipUnless(IS_CONFIG_APP, "video dependencies belong to config_app")
    def test_reconfigure_refreshes_video_headers_and_libraries(self):
        old = self.root / "old-video-sdk"
        old.mkdir()
        self.write_packages(old)

        def write_video_packages(sdk):
            for module in ("mpv", "epoxy"):
                (sdk / f"libfixture_{module}.so").touch()
                (self.pc / f"{module}.pc").write_text(
                    f"Name: {module}\nDescription: test fixture\nVersion: 1.0.0\n"
                    f"Cflags: -I{sdk}\nLibs: -L{sdk} -lfixture_{module}\n"
                )

        write_video_packages(old)
        first = self.configure()
        self.assertEqual(first.returncode, 0, first.stdout)
        for module in ("mpv", "epoxy"):
            self.assertIn(str(old / f"libfixture_{module}.so"),
                          (self.build / f"{module}.txt").read_text())

        new = self.root / "new-video-sdk"
        old.rename(new)
        self.write_packages(new)
        write_video_packages(new)
        second = self.configure()
        self.assertEqual(second.returncode, 0, second.stdout)
        for module in ("mpv", "epoxy"):
            properties = (self.build / f"{module}.txt").read_text()
            self.assertIn(str(new), properties)
            self.assertIn(str(new / f"libfixture_{module}.so"), properties)
            self.assertNotIn(str(old), properties)

        # Cached FOUND must not hide a dependency that has been uninstalled.
        (self.pc / "mpv.pc").unlink()
        missing = self.configure()
        self.assertNotEqual(missing.returncode, 0, missing.stdout)
        self.assertIn("Missing Linux development dependency: mpv", missing.stdout)


if __name__ == "__main__":
    unittest.main()
