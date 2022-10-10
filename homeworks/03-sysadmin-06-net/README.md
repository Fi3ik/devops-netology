## Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1. Работа c HTTP через телнет.

- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
- отправьте HTTP запрос

```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```

- В ответе укажите полученный HTTP код, что он означает?

```
HTTP/1.1 301 Moved Permanently
Connection: close
Content-Length: 0
Server: Varnish
Retry-After: 0
Location: <https://stackoverflow.com/questions>
Accept-Ranges: bytes
Date: Thu, 06 Oct 2022 12:44:44 GMT
Via: 1.1 varnish
X-Served-By: cache-hhn4029-HHN
X-Cache: HIT
X-Cache-Hits: 0
X-Timer: S1665060285.963218,VS0,VE0
Strict-Transport-Security: max-age=300
X-DNS-Prefetch-Control: off
```

*Код состояния HTTP 301 — стандартный код ответа HTTP, получаемый в ответ от сервера в ситуации, когда запрошенный ресурс был на постоянной основе перемещён в новое месторасположение, и указывающий на то, что текущие ссылки, использующие данный URL, должны быть обновлены. Адрес нового месторасположения ресурса указывается в поле Location получаемого в ответ заголовка пакета протокола HTTP.*

2. Повторите задание 1 в браузере, используя консоль разработчика F12.

- откройте вкладку `Network`
- отправьте запрос <http://stackoverflow.com>
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

```
Request URL: http://stackoverflow.com/
Request Method: GET
Status Code: 307 Internal Redirect
Referrer Policy: strict-origin-when-cross-origin
```

*Дольше всего обрабатывался вот этот запрос:*
```
Request URL: https://stackoverflow.com/
Request Method: GET
Status Code: 200 
Remote Address: 151.101.1.69:443
Referrer Policy: strict-origin-when-cross-origin
```

![Image alt](https://github.com/Fi3ik/devops-netology/blob/main/homeworks/03-sysadmin-06-net/scr1.png)



3. Какой IP адрес у вас в интернете?
`94.25.169.105`

5. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`

 `SCARTEL-94-25-168-0-21`
 `AS25159`

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`

 ```
traceroute -A 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gw.ipv4.layer6.net (217.12.202.1) [AS59729]  0.539 ms  0.449 ms  0.408 ms
 2  USGR.IEV.29632.as (62.205.134.194) [AS8772/AS29632]  0.211 ms  0.217 ms  0.313 ms
 3  Google.peer.b-ix.net (185.1.30.10) [*]  0.876 ms  0.845 ms  0.871 ms
 4  108.170.250.177 (108.170.250.177) [AS15169]  37.954 ms 108.170.250.161 (108.170.250.161) [AS15169]  36.690 ms  36.653 ms
 5  72.14.237.137 (72.14.237.137) [AS15169]  37.899 ms 216.239.49.199 (216.239.49.199) [AS15169]  37.588 ms 142.250.212.23 (142.250.212.23) [AS15169]  36.790 ms
 6  dns.google (8.8.8.8) [AS15169]  36.646 ms  36.677 ms  36.692 ms
```


6. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?

```
vagrant (10.0.2.15)                                                                                                                                                                                                2022-10-06T13:38:54+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                                                                                                                                                   Packets               Pings
 Host                                                                                                                                                                                            Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. _gateway                                                                                                                                                                                      0.0%    35    2.9   1.2   0.3   3.7   0.8
 2. 10.10.100.22                                                                                                                                                                                  0.0%    35    5.5   4.5   2.9   8.7   1.3
 3. 10.11.11.11                                                                                                                                                                                   0.0%    34    4.3   4.7   3.3   7.0   1.2
 4. (waiting for reply)
 5. (waiting for reply)
 6. (waiting for reply)
 7. (waiting for reply)
 8. (waiting for reply)
 9. (waiting for reply)
10. 83.149.11.226                                                                                                                                                                                 0.0%    34   22.1  94.0  21.4 526.5 117.7
11. (waiting for reply)
12. (waiting for reply)
13. 178.176.152.61                                                                                                                                                                                0.0%    34   29.4 117.0  22.8 416.8 129.4
14. 108.170.250.51                                                                                                                                                                                0.0%    34   23.2 125.9  23.2 402.4 125.7
15. 72.14.234.20                                                                                                                                                                                  0.0%    34   73.4 141.9  37.1 490.4 130.4
16. 72.14.232.190                                                                                                                                                                                 0.0%    34   41.6 131.3  36.5 576.0 134.1
17. 216.239.42.23                                                                                                                                                                                 0.0%    34   39.3 128.5  36.2 579.8 125.5
18. (waiting for reply)
```  


*Самые большие задержки:*
```
15. 72.14.234.20                                                                                                                                                                                  0.0%    34   73.4 141.9  37.1 490.4 130.4
```

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`

```
dns.google.             474     IN      A       8.8.8.8
dns.google.             474     IN      A       8.8.4.4
```

8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`

В качестве ответов на вопросы можно приложите лог выполнения команд в консоли или скриншот полученных результатов.

 ```
dig -x 8.8.8.8

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 64985
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   2595    IN      PTR     dns.google.

;; Query time: 116 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Oct 06 13:45:04 UTC 2022
;; MSG SIZE  rcvd: 73

dig -x 8.8.4.4

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 18522
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   16092   IN      PTR     dns.google.

;; Query time: 48 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Oct 06 13:45:31 UTC 2022
;; MSG SIZE  rcvd: 73
```


