{ config, pkgs, ... }:

{
  imports =
    [
      ../modules/dev.nix
      ../modules/mail.nix
      ../modules/neovim.nix
      ../modules/tmux.nix
      ../modules/users.nix
      ../modules/zsh.nix
      ../services/nix.nix
      ../services/ntp.nix
      ../services/ssh.nix
      # TODO: python (flake8, etc)
    ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";

  # install basic packages
  environment.systemPackages = with pkgs; [
    binutils
    curl
    file
    fzf
    gitAndTools.gitFull
    htop
    jq
    jwhois
    lshw
    lsof
    mercurial
    mtr
    netcat-gnu
    pwgen
    rsync
    silver-searcher
    sshfs
    strace
    tcpdump
    telnet
    tig
    tree
    unzip
    wget
    whois
    zip
  ];

  programs.bash.enableCompletion = true;
  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
  security.sudo.wheelNeedsPassword = false;
  environment.variables = {
    EDITOR = "vim";
  };
  boot.cleanTmpDir = true;
}
