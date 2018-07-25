{ config, pkgs, ... }:
let
  caffeine = pkgs.callPackage ../packages/caffeine.nix { };
  firefoxEnv = pkgs.callPackage ../packages/nightly.nix { };
  # crashplan-pro = pkgs.callPackage ../packages/crashplan-proe.nix { };
  unstable = import <nixos-unstable> {};
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import ../nixpkgs-mozilla/vidyo-overlay.nix)
    (import ../nixpkgs-mozilla/firefox-overlay.nix)
  ];

  programs.bash.enableCompletion = true;
  programs.gnupg.agent.enable = true;

  # make GDM find other WMs
  system.activationScripts.etcX11sessions = ''
    echo "setting up /etc/X11/sessions..."
    mkdir -p /etc/X11
    [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
    ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  '';

  environment.systemPackages = with pkgs; [
    # (firefox-unwrapped.override { drmSupport = true; })
    # TODO: caffeine
    # crashplan-pro
    # firefoxEnv
    # jetbrains.pycharm-professional
    VidyoDesktop
    binutils
    clementine
    curl
    file
    firefox
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
    unzip
    wget
    whois
    xorg.xbacklight
    xorg.xhost
    zip
  ];
}
