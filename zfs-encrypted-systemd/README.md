
# Create systemd service to mount zfs encrypted

Use systemd service to open luks disk and import zfs pool. This service is using 
systemd-ask-password to provide luks password, thats reason why this service need 
to be started manually. Last step is systemctl disable to avoid start on boot.
Feel free to adjust script to use key from file to unecrypt disk. 

File list:
```bash
/etc/systemd/system/zfs-encrypted.service
/usr/sbin/encryptedZfs
```

## Create encrypted disk

```bash
cryptsetup luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 /dev/sda
```

## Get proper disk UUID

```bash
ls -lah /dev/disk/by-uuid
```

## Set permissions for script

```bash
chmod 500 /usr/sbin/encryptedZfs
```

## Create pool on luks disk

```bash
cryptsetup luksOpen /dev/sda sda_crypt
zpool create fatbox /dev/mapper/sda_crypt
zpool status
zpool list
zpool export fatbox
cryptsetup luksClose sda_crypt
```

## Edit service file, write UUID for disk

```bash
systemctl enable zfs-encrypted
systemctl start zfs-encrypted.service
systemctl status zfs-encrypted.service
systemctl disable zfs-encrypted.service
```
