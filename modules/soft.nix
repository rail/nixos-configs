{ config, pkgs, ... }:
let
  firefoxEnv = pkgs.callPackage ../packages/nightly.nix { };
  unstable = import <nixos-unstable> {};
  pypi2nix_upstream = pkgs.pypi2nix.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "garbas";
      repo = "pypi2nix";
      rev = "ec42eaab4b8f4e0cdc0c8045f924cef31ea01da1";
      sha256 = "0zxwjvrn3sn25z0h1nqfzyz4kf1hnyz92699snzcfa2pi58bb969";
    };
  });
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
    # crashplan-pro
    # firefoxEnv
    # jetbrains.pycharm-professional
    VidyoDesktop
    binutils
    clementine
    curl
    file
    latest.firefox-nightly-bin
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
    p7zip
    pavucontrol
    pinentry
    pass
    polkit_gnome
    pypi2nix_upstream
    pwgen
    rsync
    unstable.pkgs.skopeo
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
