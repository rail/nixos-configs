{ config, pkgs, unstable, ... }:
let
  firefoxEnv = pkgs.callPackage ../packages/nightly.nix {
    gconf = pkgs.gnome2.GConf;
    inherit (pkgs.gnome2) libgnome libgnomeui;
    inherit (pkgs.gnome3) defaultIconTheme;
  };
  nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
in

{
  nixpkgs.overlays = [
    (import nixpkgs-mozilla)
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enableCompletion = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  environment.systemPackages = with pkgs; [
    # crashplan-pro
    # firefoxEnv
    # jetbrains.pycharm-professional
    VidyoDesktop
    binutils
    clementine
    ctags
    curl
    docker_compose
    file
    fzf
    gitAndTools.gitFull
    gitAndTools.diff-so-fancy
    gnupg
    google-chrome
    gparted
    htop
    imagemagick
    imapfilter
    insomnia
    iw
    jq
    jwhois
    latest.firefox-nightly-bin
    libreoffice-fresh
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
    pass
    pavucontrol
    pinentry
    polkit_gnome
    pwgen
    pypi2nix
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
    unstable.pkgs.skopeo
    unstable.pkgs.yarn2nix
    unzip
    wget
    whois
    xclip
    xorg.xbacklight
    xorg.xhost
    zip
  ];
}
