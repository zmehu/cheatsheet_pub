
# Create systemd service to mount zfs encrypted

Use systemd service to open luks disk and import zfs pool

File list:
/etc/systemd/system/zfs-encrypted.service
/usr/sbin/encryptedZfs

## Create encrypted disk

cryptsetup luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 /dev/sda

## Get proper disk UUID

ls -lah /dev/disk/by-uuid

## Set permissions for script

chmod 500 /usr/sbin/encryptedZfs

## Create pool on luks disk

cryptsetup luksOpen /dev/sda sda_crypt
zpool create fatbox /dev/mapper/sda_crypt
zpool status
zpool list
zpool export fatbox
cryptsetup luksClose sda_crypt

## Edit service file, write UUID for disk

systemctl enable zfs-encrypted
systemctl start zfs-encrypted.service
systemctl status zfs-encrypted.service
