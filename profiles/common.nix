{ config, pkgs, ... }:

{
  imports =
    [
      ../services/ssh.nix
      ../services/ntp.nix
      ../services/neovim.nix
      ../services/nix.nix
    ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";

  # install basic packages
  environment.systemPackages = with pkgs; [
    curl
    file
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
    sshfs
    strace
    tcpdump
    telnet
    tig
    tmux
    tree
    unzip
    wget
    whois
    zip
  ];

  programs.bash.enableCompletion = true;

  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
}
