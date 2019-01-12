{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    arcanist
    nix-index
    nodejs-10_x
    patchelf
    (yarn.override { nodejs = nodejs-10_x; })
  ];
}
