{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with pkgs.python3.pkgs; [
    autopep8
    black
    flake8
    ipython
    isort
    mypy
    notebook
    pytest
    python3Full
    virtualenv
    virtualenvwrapper
  ];
  environment.variables = {
    WORKON_HOME = pkgs.lib.mkForce "~/.local/virtualenvs";
  };
}
