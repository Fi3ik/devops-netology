# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```

```
route-views>show ip route 87.255.6.239
Routing entry for 87.255.4.0/22
  Known via "bgp 6447", distance 20, metric 10
  Tag 3257, type external
  Last update from 89.149.178.10 1d09h ago
  Routing Descriptor Blocks:
  * 89.149.178.10, from 89.149.178.10, 1d09h ago
      Route metric is 10, traffic share count is 1
      AS Hops 3
      Route tag 3257
      MPLS label: none
route-views>show bgp 87.255.6.239
BGP routing table entry for 87.255.4.0/22, version 2454439685
Paths: (22 available, best #21, table default)
  Not advertised to any peer
  Refresh Epoch 1
  3267 8641 35810
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE111746C90 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 20764 35810
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      Community: 20764:3002 20764:3011 20764:3021
      path 7FE0CC951100 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 3356 3216 35810
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE019B87F40 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 28917 35810
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 0:6939 0:16276 28917:2000 28917:2299 57866:200 65102:41441 65103:1 65104:31
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x30
        value 0000 E20A 0000 0065 0000 00C8 0000 E20A
              0000 0066 0000 A1E1 0000 E20A 0000 0067
              0000 0001 0000 E20A 0000 0068 0000 001F

      path 7FE13C4007F0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 31133 8641 35810
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE0EFBCFE10 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 20764 35810
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 8283:1 8283:101 20764:3002 20764:3011 20764:3021
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE0E389C148 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 23352 3257 28917 35810
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE082AC6E68 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 6939 35598 35810 35810
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 20912:65016
      path 7FE0F9CA6290 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 6939 35598 35810 35810
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 49788:1000
      path 7FE09DA88028 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 6939 35598 35810 35810
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 14315:2000 53767:5000
      path 7FE0E912E860 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 3491 8641 35810
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20300 101:22100 3491:300 3491:311 3491:9001 3491:9080 3491:9081 3491:9087 3491:62210 3491:62220 8641:5100 8641:6003
      path 7FE11BB8D498 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 28917 35810
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3303:1004 3303:1006 3303:1030 3303:3056 28917:2000 28917:2299
      path 7FE0E039D488 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 20764 35810
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 20764:3002 20764:3011 20764:3021
      path 7FE0E4675D60 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 3
  2497 3216 35810
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external
      path 7FE019E628D0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 3257 28917 35810
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 3257:4000 3257:8092 3257:50001 3257:50111 3257:54800 3257:54801
      path 7FE07C82DEF8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 3216 35810
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:2003 3216:4477 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
      path 7FE0EE0A4868 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 1273 3216 35810
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external
      path 7FE04F0CC8F0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 35598 35810 35810
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE01CC74AB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 3491 8641 35810
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE0BFA33138 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 3216 35810
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE0267B02C0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 28917 35810
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external, best
      Community: 3257:4000 3257:8092 3257:50001 3257:50111 3257:54800 3257:54801
      path 7FE097E2ED38 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  6939 35598 35810 35810
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external
      path 7FE149CBCB28 RPKI State not found
      rx pathid: 0, tx pathid: 0
```

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

```bash
root@vagrant:~# modprobe -v dummy numdummies=1
insmod /lib/modules/5.4.0-110-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=1
root@vagrant:~# ip link | grep dummy
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
root@vagrant:~# ip addr add 192.168.0.1/24 dev dummy0
root@vagrant:~# ip a | grep dummy
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    inet 192.168.0.1/24 scope global dummy0
root@vagrant:~# ip link | grep dummy0
3: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
root@vagrant:~# ip route add 192.168.1.0/24 via 192.168.0.1 dev dummy0
root@vagrant:~# ip r
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100
192.168.0.0/24 dev dummy0 proto kernel scope link src 192.168.0.1
192.168.1.0/24 via 192.168.0.1 dev dummy0
```

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

```bash
root@vagrant:~# ss -tpl
State                  Recv-Q                  Send-Q                                   Local Address:Port                                     Peer Address:Port                 Process
LISTEN                 0                       4096                                     127.0.0.53%lo:domain                                        0.0.0.0:*                     users:(("systemd-resolve",pid=791,fd=13))
LISTEN                 0                       128                                            0.0.0.0:ssh                                           0.0.0.0:*                     users:(("sshd",pid=883,fd=3))
LISTEN                 0                       128                                               [::]:ssh                                              [::]:*                     users:(("sshd",pid=883,fd=4))
```

|  Порт |Сервис   |
|---|---|
|  22 | sshd  |
|  53 | dns  |

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

```bash
root@vagrant:~# ss -upl
State                  Recv-Q                 Send-Q                                    Local Address:Port                                     Peer Address:Port                 Process
UNCONN                 0                      0                                         127.0.0.53%lo:domain                                        0.0.0.0:*                     users:(("systemd-resolve",pid=791,fd=12))
UNCONN                 0                      0                                        10.0.2.15%eth0:bootpc                                        0.0.0.0:*                     users:(("systemd-network",pid=789,fd=19))
```

|  Порт |Сервис   |
|---|---|
|  53 | dns  |

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.


![Image alt](https://github.com/Fi3ik/devops-netology/blob/main/homeworks/03-sysadmin-08-net/net.png)
 ---
