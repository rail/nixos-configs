{ config, pkgs, ... }:
let
  myheroku = pkgs.callPackage ../packages/heroku { };
in
{
  environment.systemPackages = with pkgs; [
    nix-repl
    yarn
    nodejs-9_x
    python36Packages.ipython
    python36Full
    patchelf
    # myheroku
  ];
}
