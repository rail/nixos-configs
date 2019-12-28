{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    arcanist
    google-cloud-sdk
    rustup
    llvmPackages_5.stdenv.cc # rustup needs it
    sops
  ];
}
