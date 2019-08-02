{ pkgs, ... }:
let
  nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  skopeo-man = pkgs.skopeo.overrideDerivation (oldAttrs: {
    postBuild = ''
      # depends on buildGoPackage not changing …
      pushd ./go/src/github.com/containers/skopeo
      make install-docs MANINSTALLDIR="$man/share/man"
      popd
    '';
  });
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
    binutils
    ctags
    curl
    dnsutils
    docker_compose
    efibootmgr
    feedreader
    file
    fzf
    exa
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
    mosh
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
    skopeo-man
    strace
    tcpdump
    telnet
    timewarrior
    transmission-gtk
    tree
    unzip
    vifm
    wget
    whois
    xclip
    xmind
    xorg.xbacklight
    xorg.xinput
    xorg.xhost
    yarn2nix
    yubikey-personalization-gui
    youtube-dl
    zip
    magic-wormhole
    zoom-us
  ];
  environment.variables = {
    BROWSER = pkgs.lib.mkForce "firefox";
    # Trick firefox so it doesn't create new profiles, see https://github.com/mozilla/nixpkgs-mozilla/issues/163
    SNAP_NAME = "firefox";
  };
}
