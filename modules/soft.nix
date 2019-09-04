{ pkgs, ... }:
let
  # nixpkgs-mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
  nixpkgs-mozilla = /home/rail/work/git/nixpkgs-mozilla;
  unstable = (import <nixos-unstable> {});
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
    unstable.starship
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
    weechat
    wget
    whois
    xclip
    xmind
    xorg.xbacklight
    xorg.xhost
    xorg.xinput
    yarn2nix
    youtube-dl
    yubikey-personalization-gui
    zip
    (unstable.zoom-us.overrideAttrs (oldAttrs: {
      meta = oldAttrs.meta // {
        # bad hack!
        license = pkgs.stdenv.lib.licenses.mit;
      };
    }))
  ];
  environment.variables = {
    BROWSER = pkgs.lib.mkForce "firefox";
    # Trick firefox so it doesn't create new profiles, see https://github.com/mozilla/nixpkgs-mozilla/issues/163
    SNAP_NAME = "firefox";
  };
}
