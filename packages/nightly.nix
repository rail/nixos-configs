{ lib, buildFHSUserEnv, stdenv }:

buildFHSUserEnv {
  name = "firefox-env";
  targetPkgs = pkgs: with pkgs; [
      stdenv.cc.cc
      alsaLib
      alsaLib.dev
      atk
      cairo
      curl
      cups
      dbus
      dbus_glib
      dbus_libs
      fontconfig
      freetype
      gdk_pixbuf
      glib
      glibc
      gst-plugins-base
      gstreamer
      gtk2
      gtk3
      kerberos
      xorg.libxcb
      xorg.libXinerama
      xorg.libXt
      libcanberra_gtk2
      mesa
      nspr
      nss
      pango
      libheimdal
      libpulseaudio
      libpulseaudio.dev
      systemd
      expat
      file
      gdb
      libnotify
      libxml2
      libxslt
      strace
      udev
      watch
      wget
      which
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.xcbutilkeysyms
      zlib
      zsh
  ];
  runScript = "$SHELL";
}
