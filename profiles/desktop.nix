{ config, pkgs, ... }:
let
  caffeine = pkgs.callPackage ../packages/caffeine.nix { };
  vidyo = pkgs.callPackage ../packages/VidyoDesktop { };
  firefoxEnv = pkgs.callPackage ../packages/nightly.nix { };
  # crashplan-pro = pkgs.callPackage ../packages/crashplan-proe.nix { };
in
{
  imports =
    [
      ./common.nix
      ../services/desktop.nix
      ../modules/fonts.nix
      # ../modules/firefox-overlay.nix
    ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # TODO: caffeine
    # TODO: crashplan pro
    # caffeine
    firefox-devedition-bin
    iw
    jetbrains.pycharm-professional
    libreoffice
    mc
    networkmanagerapplet
    polkit_gnome
    firefoxEnv
    # simplescreenrecorder
    xorg.xbacklight
    xorg.xhost
    # xmind
    vidyo
    # crashplan-pro
    # lightlocker
  ];

  networking.networkmanager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

  #nixpkgs.config.packageOverrides = pkgs:
  #  { pycurl = pkgs.python36Packages.pycurl.override { checkPhase = ''; };
  #  };

  system.activationScripts.etcX11sessions = ''
    echo "setting up /etc/X11/sessions..."
    mkdir -p /etc/X11
    [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
    ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  '';

}
