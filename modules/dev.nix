{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (yarn.override { nodejs = nodejs-10_x; })
    nodejs-10_x
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
