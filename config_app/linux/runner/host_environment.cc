#include "host_environment.h"

#include <glib.h>

void configure_host_gtk_environment() {
  const gchar* original_data_dirs =
      g_getenv("XDG_DATA_DIRS_VSCODE_SNAP_ORIG");
  if (original_data_dirs == nullptr || *original_data_dirs == '\0') {
    return;
  }

  // VS Code's classic Snap exports its own schemas and GTK modules to child
  // processes. Our native runner uses the host GTK, which must read the host
  // schemas as well (in particular on GNOME 50).
  g_autofree gchar* host_data_dirs = g_strdup(original_data_dirs);
  g_setenv("XDG_DATA_DIRS", host_data_dirs, TRUE);
  const gchar* const snap_gtk_paths[] = {
      "GSETTINGS_SCHEMA_DIR", "GTK_PATH", "GTK_EXE_PREFIX", "GTK_IM_MODULE_FILE",
      "GDK_PIXBUF_MODULE_FILE", "GDK_PIXBUF_MODULEDIR"};
  for (const gchar* name : snap_gtk_paths) {
    g_unsetenv(name);
  }
  g_unsetenv("XDG_DATA_DIRS_VSCODE_SNAP_ORIG");
}
