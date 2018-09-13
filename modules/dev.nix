{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-repl
    (yarn.override { nodejs = nodejs-9_x; })
    nodejs-9_x
    python3.pkgs.ipython
    python3.pkgs.virtualenvwrapper
    python3.pkgs.virtualenv
    python3.pkgs.flake8
    python3.pkgs.autopep8
    python3.pkgs.isort
    python3Full
    patchelf
  ];
}
