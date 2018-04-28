{ config, pkgs, ... }:
let
  caffeine = pkgs.callPackage ../packages/caffeine.nix { };
  firefoxEnv = pkgs.callPackage ../packages/nightly.nix { };
  # crashplan-pro = pkgs.callPackage ../packages/crashplan-proe.nix { };
in
{
  imports =
    [
      ./common.nix
      ../services/desktop.nix
      ../modules/fonts.nix
    ];

  nixpkgs.overlays = [
    (import ../nixpkgs-mozilla/vidyo-overlay.nix)
  ];


  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # TODO: caffeine
    google-chrome
    # firefox-devedition-bin
    # (firefox-unwrapped.override { drmSupport = true; })
    firefox
    iw
    jetbrains.pycharm-professional
    libreoffice
    mc
    networkmanagerapplet
    polkit_gnome
    firefoxEnv
    xorg.xbacklight
    xorg.xhost
    VidyoDesktop
    pavucontrol
    # crashplan-pro
    clementine
  ];

  networking.networkmanager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

  # make GDM find other WMs
  system.activationScripts.etcX11sessions = ''
    echo "setting up /etc/X11/sessions..."
    mkdir -p /etc/X11
    [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
    ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  '';

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    tcp.enable = true;
    tcp.anonymousClients.allowAll = true;
    zeroconf.discovery.enable = true;
    zeroconf.publish.enable = true;
  };
  hardware.bluetooth.enable = true;
}
