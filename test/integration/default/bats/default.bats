#!/usr/bin/env bats

@test "cryptsetup binary exists" {
  which cryptsetup
}

@test "LUKS volumed was created at /dev/loop0" {
  blkid -t TYPE=crypto_LUKS -o device | grep loop0
  cryptsetup isLuks /dev/loop0
}

@test "/etc/crypttab was updated" {
  [ $(grep '^luks-test' /etc/crypttab | wc -l) -eq "1" ]
}

@test "/etc/fstab was updated" {
  [ $(grep '^/dev/mapper/luks-test' /etc/fstab | wc -l) -eq "1" ]
}

@test "LUKS volume is mounted and writable" {
  echo whoop > /mnt/test/there_it_is
  [ -f /mnt/test/there_it_is ]
}
