## How to partition: see x1-gen5-zfs.sh
# nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# nix-channel --update
# nixos-install
## to reinstall EFI grub:
# NIXOS_INSTALL_BOOTLOADER=1 /run/current-system/bin/switch-to-configuration boot

{ pkgs, config, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  networking = {
    hostName = "rhyme";
    hostId = "e2ee7197";
  };

  boot = {
    kernelModules = [ "kvm-intel" "acpi_call" ];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

  nix.maxJobs = pkgs.lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = pkgs.lib.mkDefault "powersave";

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  # ZFS
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;
  boot.zfs.requestEncryptionCredentials = true;
  # boot.zfs = {
  #   enableUnstable = true;
  #   devNodes = "/dev/mapper";
  #   forceImportAll = true;
  #   forceImportRoot = true;
  # };

  services.throttled.enable = true;
  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";
  services.fwupd.enable = true;

  fileSystems."/" =
    { device = "rpool/ROOT/NIXOS";
      encrypted = {
        enable = true;
        blkDev = "/dev/disk/by-partlabel/cryptroot";
        label = "encrypted_root";
      };
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "rpool/HOME";
      fsType = "zfs";
    };

  fileSystems."/var/lib/docker" =
    { device = "rpool/DOCKER";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/d3edbf0a-62f6-496e-bf08-74989c9a111c";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/5125-C44F";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/e207e8a2-db40-4d96-9ff2-0b4529176d42"; }
    ];

}
