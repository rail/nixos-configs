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
  boot.zfs.requestEncryptionCredentials = true;
  services.zfs.autoScrub.enable = true;

  services.throttled.enable = true;
  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";
  services.fwupd.enable = true;

  fileSystems."/" =
    { device = "rpool/NIXOS";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "rpool/HOME";
      fsType = "zfs";
    };

  # fileSystems."/rpool/VARIOUS" =
  #   { device = "rpool/VARIOUS";
  #     fsType = "zfs";
  #   };

  fileSystems."/var/lib/docker" =
    { device = "rpool/DOCKER";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4253b41b-670f-4962-9832-3099120fed21";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/1251-A898";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/432324a0-ac55-4098-82fb-2b2f8149bbaa"; }
    ];

}
