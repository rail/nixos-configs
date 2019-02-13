{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with pkgs.python3.pkgs; [
    python3Full
    autopep8
    flake8
    ipython
    isort
    mypy
    notebook
    black
    virtualenv
    virtualenvwrapper
  ];
  environment.variables = {
    WORKON_HOME = pkgs.lib.mkForce "~/.local/virtualenvs";
  };
}
