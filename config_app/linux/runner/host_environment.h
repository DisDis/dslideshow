#ifndef RUNNER_HOST_ENVIRONMENT_H_
#define RUNNER_HOST_ENVIRONMENT_H_

// Restore host GTK paths inherited from the Snap version of VS Code. Must run
// before creating the GtkApplication or initializing GSettings/GTK.
void configure_host_gtk_environment();

#endif  // RUNNER_HOST_ENVIRONMENT_H_
