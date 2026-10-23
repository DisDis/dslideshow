#include "my_application.h"
#include "host_environment.h"

int main(int argc, char** argv) {
  configure_host_gtk_environment();
  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
