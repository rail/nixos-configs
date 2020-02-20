set -e

DISK=/dev/nvme0n1
mem="$(grep MemTotal /proc/meminfo | awk '{print $2$3}')"

gdisk ${DISK} >/dev/null <<end_of_commands
o
Y
n
1

+1024M
EF00
n
2

+4096M
8300
n
3

+${mem}
8200
n
4


8300
c
1
efi
c
2
boot
c
3
swap
c
4
rpool
w
y
end_of_commands

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


zfs create -o mountpoint=none -o reservation=1G rpool/ROOT
zfs create -o mountpoint=legacy -o reservation=1G rpool/NIXOS
zfs create -o mountpoint=legacy -o reservation=1G rpool/DOCKER
zfs create -o mountpoint=legacy -o reservation=1G -o com.sun:auto-snapshot=true  rpool/HOME

mount -t zfs rpool/NIXOS /mnt

mkdir -p /mnt/home
mount -t zfs rpool/HOME /mnt/home

mkdir -p /mnt/var/lib/docker
mount -t zfs rpool/DOCKER /mnt/var/lib/docker

mkdir -p /mnt/boot
mount /dev/disk/by-partlabel/boot /mnt/boot

mkdir -p /mnt/boot/efi
mount /dev/disk/by-partlabel/efi /mnt/boot/efi

# nixos-generate-config --root /mnt
# copy /boot, /boot/efi and swap ids
