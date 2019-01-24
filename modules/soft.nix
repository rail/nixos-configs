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
    feedreader
    file
    fzf
    gitAndTools.diff-so-fancy
    gitAndTools.gitFull
    gist
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
    lightlocker
    libreoffice-fresh
    lshw
    lsof
    mc
    mercurial
    mpv
    mtr
    netcat-gnu
    nix-prefetch-scripts
    obs-studio
    p7zip
    pamixer
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
    transmission-gtk
    tree
    unzip
    wget
    whois
    xclip
    xorg.xbacklight
    xorg.xinput
    xorg.xhost
    yarn2nix
    yubikey-personalization-gui
    youtube-dl
    zip
  ];
}
