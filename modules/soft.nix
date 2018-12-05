{ config, pkgs, ... }:
let
  nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
in

{
  nixpkgs.overlays = [
    (import nixpkgs-mozilla)
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enableCompletion = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    VidyoDesktop
    binutils
    ctags
    curl
    dnsutils
    docker_compose
    efibootmgr
    emacs
    file
    fzf
    gitAndTools.diff-so-fancy
    gitAndTools.gitFull
    gnupg
    google-chrome
    htop
    imagemagick
    imapfilter
    iw
    jq
    jwhois
    konsole
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
    psmisc
    pwgen
    pypi2nix
    rsync
    silver-searcher
    skopeo
    strace
    tcpdump
    telnet
    tig
    transmission-gtk
    tree
    unzip
    wget
    whois
    xclip
    xorg.xbacklight
    xorg.xhost
    yarn2nix
    yubikey-personalization-gui
    zip
  ];
}
