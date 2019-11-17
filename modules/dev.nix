{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    arcanist
    gnumake
    google-cloud-sdk
    nix-index
    nodejs-10_x
    patchelf
    # rustc
    # rustfmt
    # rls
    # cargo
    rustup
    llvmPackages_5.stdenv.cc # rustup needs it
    (yarn.override { nodejs = nodejs-10_x; })
    # zola
    sops
  ];
}
