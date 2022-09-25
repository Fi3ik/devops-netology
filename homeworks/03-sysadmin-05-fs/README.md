## Домашнее задание к занятию "3.5. Файловые системы"

---

### 1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

*Преимущества:*

*экономия дискового пространства. Использование разрежённых файлов считается одним из способов сжатия данных на уровне файловой системы;
отсутствие временных затрат на запись нулевых байт;
увеличение срока службы запоминающих устройств.*

*Недостатки:*

*накладные расходы на работу со списком дыр;
фрагментация файла при частой записи данных в дыры;
невозможность записи данных в дыры при отсутствии свободного места на диске;
невозможность использования других индикаторов дыр, кроме нулевых байт*.

---

### 2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

*Нет, не могут, так как жемские ссылки имеют теже права доступа, что и idnod на который они указывают.*

---

### 3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```bash
    Vagrant.configure("2") do |config|
      config.vm.box = "bento/ubuntu-20.04"
      config.vm.provider :virtualbox do |vb|
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
      end
    end
    ```

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.


![Image alt](https://github.com/Fi3ik/devops-netology/blob/main/homeworks/03-sysadmin-05-fs/newvm.jpg)
---

### 4. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.


```bash
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
loop1                       7:1    0 67.2M  1 loop /snap/lxd/21835
loop2                       7:2    0 43.6M  1 loop /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop /snap/core20/1623
loop4                       7:4    0   48M  1 loop /snap/snapd/16778
loop5                       7:5    0 67.8M  1 loop /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.5G  0 part /boot
└─sda3                      8:3    0 62.5G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
sdc                         8:32   0  2.5G  0 disk
root@vagrant:~# fdisk /dev/sdb

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xf45b5081.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-5242879, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2):
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): p
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf45b5081

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

root@vagrant:~#
root@vagrant:~#
root@vagrant:~#
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
loop1                       7:1    0 67.2M  1 loop /snap/lxd/21835
loop2                       7:2    0 43.6M  1 loop /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop /snap/core20/1623
loop4                       7:4    0   48M  1 loop /snap/snapd/16778
loop5                       7:5    0 67.8M  1 loop /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.5G  0 part /boot
└─sda3                      8:3    0 62.5G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
```
---
### 5. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.


```bash
root@vagrant:~# sfdisk -d /dev/sdb | sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xf45b5081.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xf45b5081

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop /snap/core20/1328
loop1                       7:1    0 67.2M  1 loop /snap/lxd/21835
loop2                       7:2    0 43.6M  1 loop /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop /snap/core20/1623
loop4                       7:4    0   48M  1 loop /snap/snapd/16778
loop5                       7:5    0 67.8M  1 loop /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.5G  0 part /boot
└─sda3                      8:3    0 62.5G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
└─sdc2                      8:34   0  511M  0 part
root@vagrant:~# fdisk -l /dev/sdb
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf45b5081

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
root@vagrant:~# fdisk -l /dev/sdc
Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf45b5081

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux
```
---
### 6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.


```bash
root@vagrant:~# mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b,c}1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
loop2                       7:2    0 43.6M  1 loop  /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop  /snap/core20/1623
loop4                       7:4    0   48M  1 loop  /snap/snapd/16778
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
```
---

### 7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.


```bash
root@vagrant:~# mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b,c}1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
loop2                       7:2    0 43.6M  1 loop  /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop  /snap/core20/1623
loop4                       7:4    0   48M  1 loop  /snap/snapd/16778
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
root@vagrant:~# echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
root@vagrant:~# mdadm --detail --scan | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
```

---

### 8. Создайте 2 независимых PV на получившихся md-устройствах.


```bash
root@vagrant:~# pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
root@vagrant:~# pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
```

---

### 9. Создайте общую volume-group на этих двух PV.

```bash
root@vagrant:~# vgcreate vg0 /dev/md{0,1}
```

---

### 10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

```bash
root@vagrant:~# lvcreate -L100 -n lv0 vg0 /dev/md1
```
---

### 11. Создайте `mkfs.ext4` ФС на получившемся LV.


```bash
root@vagrant:~# mkfs.ext4 /dev/vg0/lv0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

---

### 12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.


```bash
root@vagrant:~# mkdir /tmp/new
root@vagrant:~# mount /dev/vg0/lv0 /tmp/new/
root@vagrant:~# df -h
Filesystem                         Size  Used Avail Use% Mounted on
udev                               445M     0  445M   0% /dev
tmpfs                               98M  1.1M   97M   2% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   31G  3.7G   26G  13% /
tmpfs                              489M     0  489M   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
tmpfs                              489M     0  489M   0% /sys/fs/cgroup
/dev/loop0                          62M   62M     0 100% /snap/core20/1328
/dev/loop1                          68M   68M     0 100% /snap/lxd/21835
/dev/loop2                          44M   44M     0 100% /snap/snapd/14978
/dev/sda2                          1.5G   76M  1.3G   6% /boot
vagrant                            326G  193G  133G  60% /vagrant
tmpfs                               98M     0   98M   0% /run/user/1000
/dev/loop3                          64M   64M     0 100% /snap/core20/1623
/dev/loop4                          48M   48M     0 100% /snap/snapd/16778
/dev/loop5                          68M   68M     0 100% /snap/lxd/22753
/dev/mapper/vg0-lv0                 93M   72K   86M   1% /tmp/new
```
---

### 13. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.


```bash
root@vagrant:~# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2022-09-25 13:36:35--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22368678 (21M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz              100%[=================================================>]  21.33M  4.93MB/s    in 4.2s

2022-09-25 13:36:39 (5.05 MB/s) - ‘/tmp/new/test.gz’ saved [22368678/22368678]
```

---

### 14. Прикрепите вывод `lsblk`.


```bash
root@vagrant:~# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
loop1                       7:1    0 67.2M  1 loop  /snap/lxd/21835
loop2                       7:2    0 43.6M  1 loop  /snap/snapd/14978
loop3                       7:3    0 63.2M  1 loop  /snap/core20/1623
loop4                       7:4    0   48M  1 loop  /snap/snapd/16778
loop5                       7:5    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0  1.5G  0 part  /boot
└─sda3                      8:3    0 62.5G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.3G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─md1                     9:1    0 1018M  0 raid0
    └─vg0-lv0             253:1    0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─md1                     9:1    0 1018M  0 raid0
    └─vg0-lv0             253:1    0  100M  0 lvm   /tmp/new
```

---

### 15. Протестируйте целостность файла:

```bash
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```



```bash
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz
root@vagrant:/tmp/new# echo $?
0
```

---

### 16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.


```bash
root@vagrant:/tmp/new# pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 100.00%
root@vagrant:/tmp/new# lvs -a -o +devices
  LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert Devices
  ubuntu-lv ubuntu-vg -wi-ao---- <31.25g                                                     /dev/sda3(0)
  lv0       vg0       -wi-ao---- 100.00m                                                     /dev/md0(0)
```

---

### 17. Сделайте `--fail` на устройство в вашем RAID1 md.


```bash
root@vagrant:/tmp/new# mdadm /dev/md0 --fail /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
```


---

### 18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.


```bash
[200127.040765] md/raid1:md0: Disk failure on sdb1, disabling device.
                md/raid1:md0: Operation continuing on 1 devices.
```

---

### 19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

```bash
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```



```bash
root@vagrant:/tmp/new# gzip -t /tmp/new/test.gz
root@vagrant:/tmp/new# echo $?
0
```

---

### 20. Погасите тестовый хост, `vagrant destroy`.

 
 ---