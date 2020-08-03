{ pkgs, ... }:
let
  nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  master = (import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) { config = {allowUnfree = true; };});
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
    alacritty
    exercism
    ripgrep
    starship
    binutils
    ctags
    curl
    dnsutils
    docker_compose
    feedreader
    file
    fzf
    unstable.gist
    gitAndTools.diff-so-fancy
    gitAndTools.gitFull
    gnupg
    htop
    imagemagick
    imapfilter
    iw
    jq
    jwhois
    konversation
    latest.firefox-beta-bin
    libreoffice
    lshw
    lsof
    mc
    mercurial
    mpv
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
    rsync
    strace
    transmission-gtk
    tree
    unzip
    wget
    whois
    xclip
    xorg.xbacklight
    xorg.xhost
    xorg.xinput
    youtube-dl
    kitty
    zip
    emacs
    master.zoom-us
    ispell
    virt-manager
    (pkgs.callPackage ../packages/gh-cli {})
    zstd
  ];
  environment.variables = {
    BROWSER = pkgs.lib.mkForce "firefox";
    # Trick firefox so it doesn't create new profiles, see https://github.com/mozilla/nixpkgs-mozilla/issues/163
    SNAP_NAME = "firefox";
    # let `less` behave like `cat` if there less than 1 page
    LESS = "-F -X";
    QT_SCALE_FACTOR = "1.5";
  };
}
