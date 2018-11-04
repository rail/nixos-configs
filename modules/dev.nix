{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (yarn.override { nodejs = nodejs-10_x; })
    nix-index
    nodejs-10_x
    patchelf
    python3.pkgs.autopep8
    python3.pkgs.flake8
    python3.pkgs.ipython
    python3.pkgs.isort
    python3.pkgs.virtualenv
    python3.pkgs.virtualenvwrapper
    python3Full
  ];
}
