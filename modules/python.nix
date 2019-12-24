{ pkgs, ... }:

let
  unstable = (import <nixos-unstable> { config = {allowUnfree = true; };});
in

{
  environment.systemPackages = with pkgs; with pkgs.python3.pkgs; [
    autopep8
    black
    flake8
    ipython
    mypy
    notebook
    pytest
    python3Full
    virtualenv
    virtualenvwrapper
    unstable.pythonPackages.isort
  ];
  environment.variables = {
    WORKON_HOME = pkgs.lib.mkForce "~/.local/virtualenvs";
    PYTHONDONTWRITEBYTECODE = "1";
  };
}
