{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-repl
    (yarn.override { nodejs = nodejs-9_x; })
    nodejs-9_x
    python3.pkgs.ipython
    python3.pkgs.virtualenvwrapper
    python3.pkgs.virtualenv
    python3Full
    patchelf
  ];
}
