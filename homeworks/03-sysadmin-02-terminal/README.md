## Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"
---

### 1. Какого типа команда `cd`? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.**

*cd- встроенная команда*

```bash
vagrant@vagrant:~$ type cd
cd is a shell builtin
```
*cd является встроенной, так при ее выполнении должна происходить смена директории в оболочке. Если бы она не была встроенной командой, то смена директории выполнялась бы для процесса созданного оболочкой при выполнении команды, а по завершению этого процесса для оболочки бы ни каких изменений бы не произошло.*
 
---
 
### 2. Какая альтернатива без pipe команде `grep <some_string> <some_file> | wc -l`? `man grep` поможет в ответе на этот вопрос. Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.

```bash
grep -c <some_string> <some_file>
```
---

### 3. Какой процесс с PID `1` является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?

*systemd*


```bash
vagrant@vagrant:~$ pstree -p
systemd(1)─┬─ModemManager(750)─┬─{ModemManager}(766)
           │                   └─{ModemManager}(774)
           ├─VBoxService(1049)─┬─{VBoxService}(1052)
           │                   ├─{VBoxService}(1053)
           │                   ├─{VBoxService}(1056)
           │                   ├─{VBoxService}(1058)
           │                   ├─{VBoxService}(1059)
           │                   ├─{VBoxService}(1060)
           │                   ├─{VBoxService}(1061)
           │                   └─{VBoxService}(1062)
           ├─accounts-daemon(633)─┬─{accounts-daemon}(635)
           │                      └─{accounts-daemon}(647)
```
---

### 4. Как будет выглядеть команда, которая перенаправит вывод stderr `ls` на другую сессию терминала?

```bash
ls /1 2>/dev/pts/1
```
---

### 5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.

```bash
vagrant@vagrant:~$ cat < test_file_1 > test_file_2
```

---
### 6. Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?

*Да, получится.*


```bash
srvadmin@mgmt01:~$ tty
/dev/pts/2
srvadmin@mgmt01:~$ who
srvadmin tty2         2022-08-29 17:46 (tty2)
srvadmin pts/1        2022-08-29 17:48 (*.*.*.*)
srvadmin pts/2        2022-08-29 17:49 (*.*.*.*)
```

![Image alt](https://github.com/Fi3ik/devops-netology/blob/main/homeworks/03-sysadmin-02-terminal/1.png)

```bash
echo "Test" > /dev/pts/0
```

![Image alt](https://github.com/Fi3ik/devops-netology/blob/main/homeworks/03-sysadmin-02-terminal/2.png)

---
### 7. Выполните команду `bash 5>&1`. К чему она приведет? Что будет, если вы выполните `echo netology > /proc/$$/fd/5`? Почему так происходит?

*Командой `bash 5>&1`создается новый файловый дискриптор 5 и перенаправляется на файловый дискриптор stdin.
При выполнении команды `echo netology > /proc/$$/fd/5`в терминале будет выведено сообщение **netology**.*


```bash
vagrant@vagrant:~$ echo netology > /proc/$$/fd/5
netology
```

---

### 8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от `|` на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.

*Получится. Пример выполнения команды:*


```bash
vagrant@vagrant:~$ ll /111  2>&1 | wc -w
9
vagrant@vagrant:~$ ll /tmp  2>&1 | wc -w
119
```

---

### 9. Что выведет команда `cat /proc/$$/environ`? Как еще можно получить аналогичный по содержанию вывод?

*Выводятся переменные окружения. Также их можно вывести командами `env` и `printenv`*

---

### 10. Используя `man`, опишите что доступно по адресам `/proc/<PID>/cmdline`, `/proc/<PID>/exe`.

*В первом случае, это файл только на чтение, где содержится информация о процессе из командной строки, зомби процессов.*

*Во втором, это символическая ссылка на работающую программу.*

```bash
/proc/[pid]/cmdline
              This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing in this file: that is, a read on this file will  return  0  characters.   The command-line arguments appear in this file as a set of strings separated by null bytes ('\0'), with a further null byte after the last string.
```


  
```bash
/proc/[pid]/exe
              Under Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be dereferenced normally; attempting to open it will open the  executable.   You  can  even  type /proc/[pid]/exe to run another copy of the same executable that is being run by process [pid].  If the pathname has been unlinked, the symbolic link will contain the string '(deleted)' appended to the original pathname.  In a multithreaded process, the contents of this symbolic link are not available if the main thread has already terminated (typically by calling pthread_exit(3)).

              Permission to dereference or read (readlink(2)) this symbolic link is governed by a ptrace access mode PTRACE_MODE_READ_FSCREDS check; see ptrace(2).

              Under Linux 2.0 and earlier, /proc/[pid]/exe is a pointer to the binary which was executed, and appears as a symbolic link.  A readlink(2) call on this file under Linux 2.0 returns a string in the format:

                  [device]:inode

              For example, [0301]:1502 would be inode 1502 on device major 03 (IDE, MFM, etc. drives) minor 01 (first partition on the first drive).

              find(1) with the -inum option can be used to locate the file.
```


---

### 11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью `/proc/cpuinfo`.

*Версия 4_2*


```bash
grep [[:blank:]]sse* /proc/cpuinfo
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni ssse3 cx16 pcid sse4_1 sse4_2 hypervisor lahf_lm invpcid_single ibrs_enhanced fsgsbase invpcid md_clear flush_l1d arch_capabilities
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni ssse3 cx16 pcid sse4_1 sse4_2 hypervisor lahf_lm invpcid_single ibrs_enhanced fsgsbase invpcid md_clear flush_l1d arch_capabilities
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni ssse3 cx16 pcid sse4_1 sse4_2 hypervisor lahf_lm invpcid_single ibrs_enhanced fsgsbase invpcid md_clear flush_l1d arch_capabilities
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni ssse3 cx16 pcid sse4_1 sse4_2 hypervisor lahf_lm invpcid_single ibrs_enhanced fsgsbase invpcid md_clear flush_l1d arch_capabilities
```
---

### 12. При открытии нового окна терминала и `vagrant ssh` создается новая сессия и выделяется pty. Это можно подтвердить командой `tty`, которая упоминалась в лекции 3.2. Однако:


```bash
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
```

### Почитайте, почему так происходит, и как изменить поведение. 

*При удаленном выполнении команд, как показан в примере выполняется ssh-соединение без создания псевдотерминала и назначения tty, поэтому вывод команды `tty` указывает на отсутствие tty для данной сессии.
Если при выполнении команды ssh добавить ключик -t, это приведет к созданию терминала, что будет подтверждено командой tty.*


```bash
vagrant@vagrant:~$ ssh localhost 'tty'
not a tty
vagrant@vagrant:~$ ssh -t localhost 'tty'
/dev/pts/2
Connection to localhost closed.
```

*Использование ключика -t требуется в том числе, когда необходимо выполнение интерактивных програм.*

---

### 13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись `reptyr`. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.
 
*на первой вкладке*


```bash
root@vagrant:~# top
cntl+z
root@vagrant:~# jobs -l
[1]+  1466 Stopped (signal)        top
root@vagrant:~# disown 1466
```
*на второй вкладке*

```bash
root@vagrant:~# screen
reptyr  1466
```
---

### 14. `sudo echo string > /root/new_file` не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию `echo string | sudo tee /root/new_file`. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.

*Команда tee считывает информацию из стандартного ввода и переправляет его одновременно на стандартный вывод, а также копирует ее в файл или переменную. Команда с sudo tee будет работать, так как команда выполняется из под пользователя с повышением привилегий.*

---
