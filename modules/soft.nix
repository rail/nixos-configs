{ pkgs, ... }:
let
  # nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  nixpkgs-mozilla = /home/rail/work/git/nixpkgs-mozilla;
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
    exa
    fd
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
    konsole
    latest.firefox-nightly-bin
    libreoffice-fresh
    lightlocker
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
    psmisc
    pwgen
    rsync
    silver-searcher
    strace
    tcpdump
    telnet
    transmission-gtk
    tree
    unzip
    vifm
    weechat
    wget
    whois
    xclip
    xorg.xbacklight
    xorg.xhost
    xorg.xinput
    youtube-dl
    yubikey-personalization-gui
    zip
    zoom-us
  ];
  environment.variables = {
    BROWSER = pkgs.lib.mkForce "firefox";
    # Trick firefox so it doesn't create new profiles, see https://github.com/mozilla/nixpkgs-mozilla/issues/163
    SNAP_NAME = "firefox";
  };
}
