set -e

DISK=/dev/sda
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

zpool create -O atime=off \
             -O compression=lz4 \
             -O normalization=formD \
             -O snapdir=visible \
             -O xattr=sa \
             -o ashift=12 \
             -o altroot=/mnt \
            rpool /dev/mapper/root

mem="$(grep MemTotal /proc/meminfo | awk '{print $2$3}')"

zfs create -o mountpoint=none -o reservation=1G rpool/ROOT
zfs create -o mountpoint=legacy -o reservation=1G rpool/ROOT/NIXOS
zfs create -o mountpoint=legacy -o reservation=1G -o com.sun:auto-snapshot=true  rpool/HOME
zfs create -V "${mem}" -b $(getconf PAGESIZE) -o compression=zle \
    -o logbias=throughput -o sync=always -o primarycache=metadata \
    -o secondarycache=none -o com.sun:auto-snapshot=false rpool/SWAP

mkswap -L SWAP /dev/zvol/rpool/SWAP
swapon /dev/zvol/rpool/SWAP


mount -t zfs rpool/ROOT/NIXOS /mnt

mkdir -p /mnt/home
mount -t zfs rpool/HOME /mnt/home

mkdir -p /mnt/boot
mount /dev/disk/by-partlabel/boot /mnt/boot
mkdir -p /mnt/boot/efi
mount /dev/disk/by-partlabel/efi /mnt/boot/efi

# nixos-generate-config --root /mnt
# copy /boot, /boot/efi and swap ids
