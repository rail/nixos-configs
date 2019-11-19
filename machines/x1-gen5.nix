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
  boot.plymouth.enable = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/10aaef35-8d86-4d95-bb52-844f0ef230f8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7cce4446-3ae3-4d1f-9ca4-a0616abab951";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/dd7bc55a-84fe-49fe-bf0a-3a6b23b5f3f3";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/92CC-A0CA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3e7204e3-9a21-4124-b82c-62c125c94ff2"; }
    ];

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

  boot.initrd.luks.devices = [
    {
      name = "encrypted";
      device = "/dev/disk/by-uuid/51d61b94-3120-4b85-a861-4d0c3a1a7c5b";
      preLVM = true;
    }
  ];

  # # ZFS
  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.enableUnstable = true;
  # boot.loader.grub.zfsSupport = true;

  services.throttled.enable = true;
  hardware.trackpoint.device = "TPPS/2 Elan TrackPoint";
  services.fwupd.enable = true;
}
