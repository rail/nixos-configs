{ pkgs, ... }:
let
  nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  unstable = (import <nixos-unstable> { config = {allowUnfree = true; };});
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
    starship
    binutils
    ctags
    curl
    dnsutils
    docker_compose
    efibootmgr
    feedreader
    file
    fzf
    gist
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
    konversation
    latest.firefox-nightly-bin
    libreoffice-fresh
    lshw
    lsof
    magic-wormhole
    mc
    mdbook
    mercurial
    mpv
    mtr
    netcat-gnu
    nix-prefetch-scripts
    p7zip
    pamixer
    pass
    pavucontrol
    pinentry
    polkit_gnome
    powertop
    psmisc
    pwgen
    quassel
    rsync
    silver-searcher
    strace
    tcpdump
    telnet
    transmission-gtk
    tree
    unzip
    weechat
    wget
    whois
    xclip
    xorg.xbacklight
    xorg.xhost
    xorg.xinput
    youtube-dl
    yubikey-personalization-gui
    kitty
    zip
    unstable.zoom-us
    emacs
    ispell
  ];
  environment.variables = {
    BROWSER = pkgs.lib.mkForce "firefox";
    # Trick firefox so it doesn't create new profiles, see https://github.com/mozilla/nixpkgs-mozilla/issues/163
    SNAP_NAME = "firefox";
    # let `less` behave like `cat` if there less than 1 page
    LESS = "-F -X";
  };
}
