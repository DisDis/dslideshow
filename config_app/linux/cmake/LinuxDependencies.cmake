find_package(PkgConfig REQUIRED)

function(dslideshow_check_native_dependency prefix module install_packages)
  # FindPkgConfig otherwise reuses include paths from a previous configuration,
  # even when the distro has since removed or relocated the development files.
  unset(__pkg_config_checked_${prefix} CACHE)
  # FindPkgConfig also caches absolute library paths separately from its module
  # results. Refresh both when a temporary SDK has gone away or changed.
  get_cmake_property(cache_variables CACHE_VARIABLES)
  foreach(cache_variable IN LISTS cache_variables)
    if(cache_variable MATCHES "^pkgcfg_lib_${prefix}_")
      unset(${cache_variable} CACHE)
    endif()
  endforeach()
  pkg_check_modules(${prefix} QUIET IMPORTED_TARGET GLOBAL ${module})

  if(NOT ${prefix}_FOUND)
    message(FATAL_ERROR
      "Missing Linux development dependency: ${module}.\n"
      "On Debian/Ubuntu install: sudo apt-get install ${install_packages}\n"
      "Then run ./build_linux.sh from config_app. For a cross-build, "
      "check PKG_CONFIG_LIBDIR and PKG_CONFIG_SYSROOT_DIR for the target sysroot.")
  endif()

  foreach(include_dir IN LISTS ${prefix}_INCLUDE_DIRS)
    if(NOT IS_DIRECTORY "${include_dir}")
      message(FATAL_ERROR
        "pkg-config reports a missing include directory for ${module}: "
        "${include_dir}\n"
        "Repair the development package owning this directory (on "
        "Debian/Ubuntu start with ${install_packages} and their dependencies). "
        "Check PKG_CONFIG_PATH, PKG_CONFIG_LIBDIR and PKG_CONFIG_SYSROOT_DIR "
        "if using a custom SDK. Then run ./build_linux.sh again.")
    endif()
  endforeach()
endfunction()

set(gtk_development_packages "clang lld cmake ninja-build pkg-config libgtk-3-dev liblzma-dev")
dslideshow_check_native_dependency(GTK gtk+-3.0 "${gtk_development_packages}")
dslideshow_check_native_dependency(GLIB glib-2.0 "${gtk_development_packages}")
dslideshow_check_native_dependency(GIO gio-2.0 "${gtk_development_packages}")

# Use the same case-sensitive prefixes as media_kit_video so its imported
# targets and include variables use the refreshed results in VS Code as well.
dslideshow_check_native_dependency(mpv mpv "libmpv-dev libepoxy-dev")
dslideshow_check_native_dependency(epoxy epoxy "libmpv-dev libepoxy-dev")
