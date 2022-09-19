## Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

---

### 1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

- поместите его в автозагрузку,
- предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
- удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.



```bash
root@vagrant:~# tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz
root@vagrant:~# mv node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/
root@vagrant:~# vim /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target
[Service]
Type=simple
EnviromentFile=/usr/lib/etc/node_exporter
ExecStart=/usr/local/bin/node_exporter $OPTIONS
Restart=always
[Install]
WantedBy=multi-user.target

mkdir -p /var/lib/node_exporter/textfile_collector

root@vagrant:~# vim /usr/local/etc/node_exportet
OPTIONS="--collector.textfile.directory /var/lib/node_exporter/textfile_collector"

root@vagrant:~# systemctl enable --now node_exporter
Created symlink /etc/systemd/system/multi-user.target.wants/node_exporter.service → /etc/systemd/system/node_exporter.service.
root@vagrant:~# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2022-09-18 11:32:17 UTC; 13s ago
   Main PID: 4428 (node_exporter)
      Tasks: 6 (limit: 2244)
     Memory: 2.8M
     CGroup: /system.slice/node_exporter.service
             └─4428 /usr/local/bin/node_exporter

Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=thermal_zone
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=time
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=timex
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=udp_queues
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=uname
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=vmstat
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=xfs
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.142Z caller=node_exporter.go:115 level=info collector=zfs
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.147Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
Sep 18 11:32:17 vagrant node_exporter[4428]: ts=2022-09-18T11:32:17.149Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false

reboot

● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2022-09-18 11:41:22 UTC; 1min 59s ago
   Main PID: 661 (node_exporter)
      Tasks: 5 (limit: 2244)
     Memory: 14.9M
     CGroup: /system.slice/node_exporter.service
             └─661 /usr/local/bin/node_exporter

Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.591Z caller=node_exporter.go:115 level=info collector=thermal_zone
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.591Z caller=node_exporter.go:115 level=info collector=time
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.591Z caller=node_exporter.go:115 level=info collector=timex
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.591Z caller=node_exporter.go:115 level=info collector=udp_queues
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=uname
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=vmstat
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=xfs
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=zfs
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.597Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false

root@vagrant:~# systemctl stop node_exporter
root@vagrant:~# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Sun 2022-09-18 12:07:15 UTC; 1s ago
    Process: 661 ExecStart=/usr/local/bin/node_exporter $OPTIONS (code=killed, signal=TERM)
   Main PID: 661 (code=killed, signal=TERM)

Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.591Z caller=node_exporter.go:115 level=info collector=udp_queues
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=uname
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=vmstat
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=xfs
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:115 level=info collector=zfs
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.592Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
Sep 18 11:41:23 vagrant node_exporter[661]: ts=2022-09-18T11:41:23.597Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false
Sep 18 12:07:15 vagrant systemd[1]: Stopping Node Exporter...
Sep 18 12:07:15 vagrant systemd[1]: node_exporter.service: Succeeded.
Sep 18 12:07:15 vagrant systemd[1]: Stopped Node Exporter.


root@vagrant:~# systemctl start node_exporter
root@vagrant:~# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2022-09-18 12:07:31 UTC; 2s ago
   Main PID: 1480 (node_exporter)
      Tasks: 5 (limit: 2244)
     Memory: 2.8M
     CGroup: /system.slice/node_exporter.service
             └─1480 /usr/local/bin/node_exporter

Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=thermal_zone
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=time
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=timex
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=udp_queues
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=uname
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=vmstat
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=xfs
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:115 level=info collector=zfs
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=node_exporter.go:199 level=info msg="Listening on" address=:9100
Sep 18 12:07:31 vagrant node_exporter[1480]: ts=2022-09-18T12:07:31.348Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false
```


---
### 2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
---

CPU. `sum by (mode, instance) (rate(node_cpu_seconds_total{job="node"}[1m]))`

Память.  `(node_memory_MemFree_bytes/node_memory_MemTotal_bytes)* 100`

Диски. `(node_filesystem_avail_bytes/node_filesystem_size_bytes)*100`

Сеть. `rate(node_network_receive_bytes_total[1m]), rate(node_network_transmit_bytes_total[1m])`

### 3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:

- в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
- добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:
```bash
config.vm.network "forwarded_port", guest: 19999, host: 19999
```

### После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

![Image alt](https://github.com/Fi3ik/devops-netology/blob/main/homeworks/03-sysadmin-04-os/netdata.jpg)

---
### 4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

*Да, возможно*

```bash
[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000] Hypervisor detected: KVM
[    0.012749] CPU MTRRs all blank - virtualized system.
```


---
### 5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?


`sysctl fs.nr_open` *- максимальное количество открываемых дескрипторов, так же можно посмотреть в * ` cat /proc/sys/fs/nr_open`

```bash
root@vagrant:~# sysctl fs.nr_open
fs.nr_open = 1048576

root@vagrant:~# cat /proc/sys/fs/nr_open
1048576
```

`ulimim` - *ограничение текущих процессов, которые могут быть мягкими (soft), пользователь получит предупреждение, о достижении предела значения soft и жестки (hard), данные пределы превысит не получится. Изменять ограничения можно как используя утилиту ulimit, так и в конфигурационном файле* `/etc/security/limits.conf`

*На примере ниже показаны ограничения на максимальное количество открываемых файлов, в первом случае, это мякие ограничения, втором это жесткие*

```bash
root@vagrant:~# ulimit -n
1024
root@vagrant:~# ulimit -n -H
1048576
```

*Перечень доступных ограничений:*

```bash
      -b        the socket buffer size
      -c        the maximum size of core files created
      -d        the maximum size of a process's data segment
      -e        the maximum scheduling priority (`nice')
      -f        the maximum size of files written by the shell and its children
      -i        the maximum number of pending signals
      -k        the maximum number of kqueues allocated for this process
      -l        the maximum size a process may lock into memory
      -m        the maximum resident set size
      -n        the maximum number of open file descriptors
      -p        the pipe buffer size
      -q        the maximum number of bytes in POSIX message queues
      -r        the maximum real-time scheduling priority
      -s        the maximum stack size
      -t        the maximum amount of cpu time in seconds
      -u        the maximum number of user processes
      -v        the size of virtual memory
      -x        the maximum number of file locks
      -P        the maximum number of pseudoterminals
      -T        the maximum number of threads
```

---
### 6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.


```bash
root@vagrant:~# unshare --fork --pid --mount-proc sleep 1h
^Z
[1]+  Stopped                 unshare --fork --pid --mount-proc sleep 1h
root@vagrant:~# bg
[1]+ unshare --fork --pid --mount-proc sleep 1h &
root@vagrant:~# ps
    PID TTY          TIME CMD
   1596 pts/0    00:00:00 sudo
   1598 pts/0    00:00:00 su
   1599 pts/0    00:00:00 bash
  48396 pts/0    00:00:00 unshare
  48397 pts/0    00:00:00 sleep
  48398 pts/0    00:00:00 ps
root@vagrant:~# nsenter --target 48397 --mount --pid
root@vagrant:/# ps
    PID TTY          TIME CMD
      1 pts/0    00:00:00 sleep
      2 pts/0    00:00:00 bash
     13 pts/0    00:00:00 ps
root@vagrant:/#
```


---
### 7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

*fork-бомба, где ":"- объявлена функцией, которая вызывает сама себя порождая огромное количество процессов пока не упрется в ограничение количества процессов для пользователя. Ограничения можно посмотреть командой ulimit -u.*

`[40220.801565] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-21.scope`

```bash
vagrant@vagrant:~$ ulimit -H -u
7483
```

*Ограничить количество создаваемых процессов на пользователя можно командой*

`vagrant@vagrant:~$ ulimit -H -u 1000`

*Лимиты, установленные данной командой валидны только для текущей сессии для того, чтобы задать постоянные ограничения необходимо эти ограничения прописать в конфигурационном файле* `/etc/security/limits.confs`
