{ writeScriptBin
, stdenv, fetchurl, config, wrapGAppsHook
, alsaLib
, atk
, cairo
, curl
, cups
, dbus_glib
, dbus_libs
, fontconfig
, freetype
, gdk_pixbuf
, glib
, glibc
, gst-plugins-base
, gstreamer
, gtk2
, gtk3
, kerberos
, libX11
, libXScrnSaver
, libxcb
, libXcomposite
, libXdamage
, libXext
, libXfixes
, libXinerama
, libXrender
, libXt
, libcanberra_gtk2
, mesa
, nspr
, nss
, pango
, libheimdal
, libpulseaudio
, coreutils
}:

let

  libPath = stdenv.lib.makeLibraryPath
    [ stdenv.cc.cc
      alsaLib
      alsaLib.dev
      atk
      cairo
      curl
      cups
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
      libX11
      libXScrnSaver
      libXcomposite
      libxcb
      libXdamage
      libXext
      libXfixes
      libXinerama
      libXrender
      libXt
      libcanberra_gtk2
      mesa
      nspr
      nss
      pango
      libheimdal
      libpulseaudio
      libpulseaudio.dev
    ] + ":" + stdenv.lib.makeSearchPathOutput "lib" "lib64" [
      stdenv.cc.cc
    ];


in

writeScriptBin "fff" ''
  #!${stdenv.shell}
  FF_DIR=~/Downloads/firefox
  ${glibc}/lib/ld-linux-x86-64.so.2 --library-path ${libPath}:$FF_DIR $FF_DIR/firefox
''
