{ config, pkgs, ... }:
let
  caffeine = pkgs.callPackage ../packages/caffeine.nix { };
  firefoxEnv = pkgs.callPackage ../packages/nightly.nix { };
  unstable = import <nixos-unstable> {};
in

{
  nixpkgs.overlays = [
    (import ../nixpkgs-mozilla/vidyo-overlay.nix)
    (import ../nixpkgs-mozilla/firefox-overlay.nix)
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enableCompletion = true;
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    # TODO: caffeine
    # crashplan-pro
    # firefoxEnv
    # jetbrains.pycharm-professional
    VidyoDesktop
    binutils
    clementine
    curl
    file
    firefox-nightly-bin
    fzf
    gitAndTools.gitFull
    gnupg
    google-chrome
    gparted
    htop
    imapfilter
    insomnia
    iw
    jq
    jwhois
    libreoffice
    lightlocker
    lshw
    lsof
    mc
    mercurial
    mtr
    netcat-gnu
    networkmanagerapplet
    nix-prefetch-scripts
    pavucontrol
    pinentry
    pass
    polkit_gnome
    pwgen
    rsync
    silver-searcher
    sshfs
    strace
    tcpdump
    telnet
    tig
    transmission-gtk
    tree
    unstable.pkgs.gnucash
    unstable.pkgs.magic-wormhole
    unstable.pkgs.yarn2nix
    unzip
    wget
    whois
    xscreensaver
    xorg.xbacklight
    xorg.xhost
    zip
  ];
}
