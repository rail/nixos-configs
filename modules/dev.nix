{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; with pkgs.python3Packages; [
    # (google-cloud-sdk.override (oldAttrs: { python = pkgs.python2; }))
    # google-cloud-sdk
    rustup
    clang
    # sops
    # vscode
    yarn
    gcc

    # Python
    autopep8
    black
    flake8
    ipython
    python3Full
    virtualenv
    virtualenvwrapper
    # isort
    mypy
#    python-language-server
  ];

  environment.variables = {
    WORKON_HOME = pkgs.lib.mkForce "~/.local/virtualenvs";
    PYTHONDONTWRITEBYTECODE = "1";
  };
}
