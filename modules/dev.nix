{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    arcanist
    gnumake
    nix-index
    nodejs-10_x
    patchelf
    (yarn.override { nodejs = nodejs-10_x; })
  ];
}
