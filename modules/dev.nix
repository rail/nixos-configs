{ pkgs, ... }:

let
  unstable = (import <nixos-unstable> { config = {allowUnfree = true; };});
in

{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; with pkgs.python3Packages; [
    arcanist
    (google-cloud-sdk.override (oldAttrs: { python = pkgs.python2; }))
    rustup
    llvmPackages_5.stdenv.cc # rustup needs it
    sops
    unstable.vscode

    # Python
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
    unstable.pythonPackages.tox

  ];

  environment.variables = {
    WORKON_HOME = pkgs.lib.mkForce "~/.local/virtualenvs";
    PYTHONDONTWRITEBYTECODE = "1";
  };
}
