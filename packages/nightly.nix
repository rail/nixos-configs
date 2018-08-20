{ lib, buildFHSUserEnv, stdenv, gconf, libgnome, libgnomeui, defaultIconTheme }:

buildFHSUserEnv {
  name = "firefox-env";
  targetPkgs = pkgs: with pkgs; [
    stdenv.cc.cc
    alsaLib
    (lib.getDev alsaLib)
    atk
    cairo
    curl
    cups
    dbus-glib
    dbus
    fontconfig
    freetype
    gconf
    gdk_pixbuf
    glib
    glibc
    gtk2
    gtk3
    kerberos
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libxcb
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXinerama
    xorg.libXrender
    xorg.libXt
    libcanberra-gtk2
    libgnome
    libgnomeui
    libnotify
    libGLU_combined
    nspr
    nss
    pango
    libheimdal
    libpulseaudio
    (lib.getDev libpulseaudio)
    systemd
    ffmpeg
    zsh
  ];
  runScript = "$SHELL";
}
