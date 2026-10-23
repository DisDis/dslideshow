find_package(PkgConfig REQUIRED)

function(dslideshow_check_native_dependency prefix module)
  # FindPkgConfig otherwise reuses include paths from a previous configuration,
  # even when the distro has since removed or relocated the development files.
  unset(__pkg_config_checked_${prefix} CACHE)
  pkg_check_modules(${prefix} QUIET IMPORTED_TARGET GLOBAL ${module})

  if(NOT ${prefix}_FOUND)
    message(FATAL_ERROR
      "Missing Linux development dependency: ${module}.\n"
      "On Debian/Ubuntu install: sudo apt-get install clang lld cmake ninja-build "
      "pkg-config libgtk-3-dev liblzma-dev\n"
      "Then run ./build_linux.sh from dslideshow_flutter. For a cross-build, "
      "check PKG_CONFIG_LIBDIR and PKG_CONFIG_SYSROOT_DIR for the target sysroot.")
  endif()

  foreach(include_dir IN LISTS ${prefix}_INCLUDE_DIRS)
    if(NOT IS_DIRECTORY "${include_dir}")
      message(FATAL_ERROR
        "pkg-config reports a missing include directory for ${module}: "
        "${include_dir}\n"
        "Repair the development package owning this directory (for GTK on "
        "Debian/Ubuntu start with libgtk-3-dev and its dependencies). "
        "Check PKG_CONFIG_PATH, PKG_CONFIG_LIBDIR and PKG_CONFIG_SYSROOT_DIR "
        "if using a custom SDK. Then run ./build_linux.sh again.")
    endif()
  endforeach()
endfunction()

dslideshow_check_native_dependency(GTK gtk+-3.0)
dslideshow_check_native_dependency(GLIB glib-2.0)
dslideshow_check_native_dependency(GIO gio-2.0)
