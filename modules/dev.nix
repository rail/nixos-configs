{ pkgs, ... }:
{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; with pkgs.python3Packages; [
    arcanist
    (google-cloud-sdk.override (oldAttrs: { python = pkgs.python2; }))
    sops

    # Python
    autopep8
    black
    flake8
    ipython
    python3Full
    virtualenv
    virtualenvwrapper
    isort
    mypy
  ];

  environment.variables = {
    WORKON_HOME = pkgs.lib.mkForce "~/.local/virtualenvs";
    PYTHONDONTWRITEBYTECODE = "1";
  };
}
