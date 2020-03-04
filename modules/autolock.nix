{ pkgs, ... }:

let
  lockerCommand = "${pkgs.i3lock-color}/bin/i3lock-color --clock --indicator";
in

{
  services.xserver = {
    xautolock =  {
      enable = true;
      killer = null;
      extraOptions = [ "-lockaftersleep" ];
      locker = lockerCommand;
      nowlocker = lockerCommand;
    };
  };
  programs.xss-lock = {
    enable = true;
    inherit lockerCommand;
  };
}
