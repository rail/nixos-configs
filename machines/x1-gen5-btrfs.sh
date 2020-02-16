set -e

DISK=/dev/nvme0n1
PASS=$1

gdisk ${DISK} >/dev/null <<end_of_commands
o
Y
n
1

+1024M
EF00
n
2

+1024M
8300
n
3


8300
c
1
efi
c
2
boot
c
3
cryptroot
w
y
end_of_commands

partprobe $DISK
sleep 10

mkfs.vfat /dev/disk/by-partlabel/efi
mkfs.ext4 /dev/disk/by-partlabel/boot

dd if=/dev/urandom of=/tmp/keyfile bs=1k count=8
echo "YES" | cryptsetup luksFormat /dev/disk/by-partlabel/cryptroot --key-size 512 --hash sha512 --key-file /tmp/keyfile
echo "$PASS" | cryptsetup luksAddKey /dev/disk/by-partlabel/cryptroot --key-file /tmp/keyfile
cryptsetup luksOpen /dev/disk/by-partlabel/cryptroot root -d /tmp/keyfile
cryptsetup luksRemoveKey /dev/disk/by-partlabel/cryptroot /tmp/keyfile
rm -f /tmp/keyfile

mkfs.btrfs -L root /dev/mapper/root
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=zstd,space_cache /dev/mapper/root /mnt/
btrfs subvolume create /mnt/nixos
umount /mnt
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=zstd,space_cache,subvol=nixos /dev/mapper/root /mnt/

btrfs subvolume create /mnt/home
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=zstd,space_cache,subvol=home /dev/mapper/root /mnt/home

mkdir -p /mnt/var/lib
btrfs subvolume create /mnt/var/lib/docker
mount -t btrfs -o noatime,discard,ssd,autodefrag,compress=zstd,space_cache,subvol=var/lib/docker /dev/mapper/root /mnt/var/lib/docker

mkdir -p /mnt/boot
mount /dev/disk/by-partlabel/boot /mnt/boot

mkdir -p /mnt/boot/efi
mount /dev/disk/by-partlabel/efi /mnt/boot/efi

# nixos-generate-config --root /mnt
# copy /boot, /boot/efi and swap ids
