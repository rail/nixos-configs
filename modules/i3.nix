{ config, pkgs, ... }:

let
  py3status = pkgs.python3Packages.py3status.override {
    propagatedBuildInputs = with pkgs.python3Packages; [ pytz tzlocal requests ];
    prePatch = ''
      sed -i -e "s|'file|'${pkgs.file}/bin/file|" py3status/parse_config.py
      sed -i -e "s|\[\"acpi\"|\[\"${pkgs.acpi}/bin/acpi\"|" py3status/modules/battery_level.py
      sed -i -e "s|notify-send|${pkgs.libnotify}/bin/notify-send|" py3status/modules/battery_level.py
      sed -i -e "s|/usr/bin/whoami|${pkgs.coreutils}/bin/whoami|" py3status/modules/external_script.py
      sed -i -e "s|'amixer|'${pkgs.alsaUtils}/bin/amixer|" py3status/modules/volume_status.py
      sed -i -e "s|'i3-nagbar|'${pkgs.i3}/bin/i3-nagbar|" py3status/modules/pomodoro.py
      sed -i -e "s|'free|'${pkgs.procps}/bin/free|" py3status/modules/sysdata.py
      sed -i -e "s|'sensors|'${pkgs.lm_sensors}/bin/sensors|" py3status/modules/sysdata.py
      sed -i -e "s|'setxkbmap|'${pkgs.xorg.setxkbmap}/bin/setxkbmap|" py3status/modules/keyboard_layout.py
      sed -i -e "s|'xset|'${pkgs.xorg.xset}/bin/xset|" py3status/modules/keyboard_layout.py
      sed -i -e "s|/sbin/iw|${pkgs.iw}/bin/iw|" py3status/modules/wifi.py
    '';

  };

in

{

  # services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    compton
    dmenu
    dunst
    feh
    i3lock
    i3status
    libnotify
    py3status
    rofi
  ];

}
