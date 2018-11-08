{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    xsane = pkgs.xsane.override { gimpSupport = true; };
  };
  hardware.sane.enable = true;
  environment.systemPackages = with pkgs; [
    xsane
    gimp
  ];

}
