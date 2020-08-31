set -e

# to wipe the disk:
# 1. print system info
# dmidecode -t system | head -n14
# shred -v -n1 /dev/xxx

DISK=/dev/nvme0n1
mem="$(grep MemTotal /proc/meminfo | awk '{print $2$3}')"

wipefs -af $DISK
sgdisk -Zo $DISK

# /boot/efi
sgdisk -n1:0:+1024M -t1:EF00 -c1:efi $DISK
# /boot
sgdisk -n2:0:+4096M -t2:8300 -c2:boot $DISK
# swap
sgdisk -n3:0:+${mem} -t3:8200 -c3:swap $DISK
# zfs
sgdisk -n4:0:0 -t4:8300 -c4:rpool $DISK

partprobe $DISK
sleep 10

mkfs.vfat /dev/disk/by-partlabel/efi
mkfs.ext4 /dev/disk/by-partlabel/boot

mkswap -L SWAP /dev/disk/by-partlabel/swap
swapon /dev/disk/by-partlabel/swap

zpool create -O atime=off \
             -O compression=lz4 \
             -O normalization=formD \
             -O encryption=aes-256-gcm \
             -O keyformat=passphrase \
             -O xattr=sa \
             -o ashift=12 \
             -o altroot=/mnt \
            rpool /dev/disk/by-partlabel/rpool


zfs create -o mountpoint=none rpool/local
zfs create -o mountpoint=none rpool/safe

zfs create -o mountpoint=legacy -o reservation=1G rpool/local/root
zfs create -o mountpoint=legacy -o reservation=1G rpool/local/nix
zfs create -o mountpoint=legacy -o reservation=1G rpool/local/docker
zfs create -o mountpoint=legacy -o reservation=1G rpool/safe/home

mkdir -p \
    /mnt/var/lib/docker \
    /mnt/home \
    /mnt/boot/efi \
    /mnt/nix

mount -t zfs rpool/local/root /mnt
mount -t zfs rpool/local/nix /mnt/nix
mount -t zfs rpool/local/docker /mnt/var/lib/docker
mount -t zfs rpool/safe/home /mnt/home
mount /dev/disk/by-partlabel/boot /mnt/boot
mount /dev/disk/by-partlabel/efi /mnt/boot/efi

# nixos-generate-config --root /mnt
# nixos-generate-config --root /mnt --show-hardware-config
# copy /boot, /boot/efi and swap ids

# create these after generating configs, so they are not in the list of legacy
# mounted volumes
zfs create -o mountpoint=/home/rail/Downloads rpool/local/Downloads
zfs create -o mountpoint=/home/rail/Videos rpool/local/Videos
zfs create -o mountpoint="/home/rail/VirtualBox VMs" rpool/local/VirtualBoxVMs
