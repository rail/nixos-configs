## How to reinstall:
# cryptsetup luksOpen /dev/nvme0n1p8 railz
# lvchange -ay railz
# mount /dev/mapper/railz-nixos /mnt
# mount /dev/mapper/railz-home /mnt/home
## mounting /boot and /boot/efi separately makes nixos-rebuild to not install
## kernels on a small EFI partition
# mount /dev/nvme0n1p6 /mnt/boot (ext4)
# mount /dev/nvme0n1p3 /mnt/boot/efi/ (shared efi partition)
# swapon /dev/mapper/railz-swap
# nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# nix-channel --update
## disable builtins.fetchTarball based expressions, because the installer is
## unable to fetch them and unpack into a read-only store
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
    enableCryptodisk = true;
    zfsSupport = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  # # ZFS
  boot.supportedFilesystems = [ "zfs" ];
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

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/"; }
    ];

}
