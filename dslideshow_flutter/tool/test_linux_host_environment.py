"""Check the VS Code Snap workaround without opening GTK or the application."""

import os
from pathlib import Path
import shlex
import subprocess
import tempfile
import unittest


RUNNER = Path(__file__).resolve().parents[1] / "linux/runner"
SNAP_GTK_PATHS = (
    "GSETTINGS_SCHEMA_DIR", "GTK_PATH", "GTK_EXE_PREFIX", "GTK_IM_MODULE_FILE",
    "GDK_PIXBUF_MODULE_FILE", "GDK_PIXBUF_MODULEDIR",
)
KEYS = (*SNAP_GTK_PATHS, "XDG_DATA_DIRS", "XDG_DATA_DIRS_VSCODE_SNAP_ORIG", "GDK_BACKEND")


class HostEnvironmentTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory()
        cls.addClassCleanup(cls.temp.cleanup)
        root = Path(cls.temp.name)
        source = root / "check.cc"
        names = ", ".join(f'"{key}"' for key in KEYS)
        source.write_text(
            '#include "host_environment.h"\n#include <glib.h>\n'
            'int main() {\n'
            '  configure_host_gtk_environment();\n'
            '  configure_host_gtk_environment(); // Must be idempotent.\n'
            f'  const char* keys[] = {{{names}}};\n'
            '  for (const char* key : keys) {\n'
            '    const char* value = g_getenv(key);\n'
            '    if (value) g_print("%s=%s\\n", key, value);\n'
            '  }\n}\n'
        )
        cls.binary = root / "check"
        flags = shlex.split(subprocess.check_output(
            ["pkg-config", "--cflags", "--libs", "glib-2.0"], text=True))
        subprocess.run(
            ["clang++", "-std=c++14", "-Wall", "-Wextra", "-Werror",
             "-I", str(RUNNER), str(source), str(RUNNER / "host_environment.cc"),
             "-o", str(cls.binary), *flags], check=True,
        )

    def configure(self, values):
        env = {key: value for key, value in os.environ.items() if key not in KEYS}
        env.update(values)
        result = subprocess.run([str(self.binary)], env=env, check=True,
                                text=True, stdout=subprocess.PIPE)
        return dict(line.split("=", 1) for line in result.stdout.splitlines())

    def test_normal_launch_keeps_custom_paths(self):
        custom = {key: f"/custom/{key}" for key in SNAP_GTK_PATHS}
        custom.update(XDG_DATA_DIRS="/custom/data:/usr/share", GDK_BACKEND="wayland")
        self.assertEqual(self.configure(custom), custom)

    def test_empty_snap_origin_does_not_change_environment(self):
        custom = {"XDG_DATA_DIRS_VSCODE_SNAP_ORIG": "",
                  "XDG_DATA_DIRS": "/custom/data", "GSETTINGS_SCHEMA_DIR": "/custom/schemas"}
        self.assertEqual(self.configure(custom), custom)

    def test_snap_launch_restores_host_paths_without_forcing_x11(self):
        snap = {key: f"/snap/code/271/{key}" for key in SNAP_GTK_PATHS}
        snap.update(XDG_DATA_DIRS="/snap/code/271/usr/share:/usr/share",
                    XDG_DATA_DIRS_VSCODE_SNAP_ORIG="/usr/local/share:/usr/share",
                    GDK_BACKEND="wayland")
        self.assertEqual(self.configure(snap), {
            "XDG_DATA_DIRS": "/usr/local/share:/usr/share", "GDK_BACKEND": "wayland",
        })


if __name__ == "__main__":
    unittest.main()
