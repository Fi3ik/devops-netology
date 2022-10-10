# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.


```bash
root@vagrant:~# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
Generating a RSA private key

Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:Moscow
Locality Name (eg, city) []:Moscow
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Home
Organizational Unit Name (eg, section) []:Home
Common Name (e.g. server FQDN or YOUR name) []:10.0.2.15
Email Address []:v******@gmail.com
```

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

```bash
root@vagrant:~# ./testssl.sh https://www.ya.com/

ATTENTION: No cipher mapping file found!
Please note from 2.9 on testssl.sh needs files in "$TESTSSL_INSTALL_DIR/etc/" to function correctly.

Type "yes" to ignore this warning and proceed at your own risk --> yes

ATTENTION: No TLS data file found -- needed for socket-based handshakes
Please note from 2.9 on testssl.sh needs files in "$TESTSSL_INSTALL_DIR/etc/" to function correctly.

Type "yes" to ignore this warning and proceed at your own risk --> yes

No engine or GOST support via engine with your /usr/bin/openssl

###########################################################
    testssl.sh       3.0.8 from https://testssl.sh/

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.1.1f  31 Mar 2020" [~0 ciphers]
 on vagrant:/usr/bin/openssl
 (built: "May  3 17:49:36 2022", platform: "debian-amd64")


 Start 2022-10-10 13:33:05        -->> 89.39.182.172:443 (www.ya.com) <<--

 rDNS (89.39.182.172):   --
Error setting TLSv1.3 ciphersuites
139723018126656:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
 Testing with www.ya.com:443 only worked using /usr/bin/openssl.
 Test results may be somewhat better if the --ssl-native option is used.
 Type "yes" to proceed and accept false negatives or positives --> yes
 Service detected:       HTTP

 Pre-test: 128 cipher limit bug

 Testing protocols via sockets except NPN+ALPN

 SSLv2      not offered (OK)
 SSLv3      not offered (OK)
 TLS 1      not offered
 TLS 1.1    not offered
 TLS 1.2    offered (OK)
 TLS 1.3    not offered -- connection failed rather than downgrading to TLSv1.2
 NPN/SPDY   not offered
 ALPN/HTTP2 http/1.1 (offered)

 Testing cipher categories

 NULL ciphers (no encryption)                  not offered (OK)
 Anonymous NULL Ciphers (no authentication)    not offered (OK)
 Export ciphers (w/o ADH+NULL)                 not offered (OK)
 LOW: 64 Bit + DES, RC[2,4] (w/o export)       not offered (OK)
 Triple DES Ciphers / IDEA                     not offered
 Obsolete CBC ciphers (AES, ARIA etc.)         Error setting TLSv1.3 ciphersuites
140005114291520:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
offered
 Strong encryption (AEAD ciphers)              Error setting TLSv1.3 ciphersuites
140015439381824:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
offered (OK)


 Testing robust (perfect) forward secrecy, (P)FS -- omitting Null Authentication/Encryption, 3DES, RC4
 Cipher mapping not available, doing a fallback to openssl

Local problem: You only have 1 PFS ciphers on the client side

 Testing server preferences

 Has server cipher order?     yes (OK)
 Negotiated protocol          TLSv1.2
 Negotiated cipher            AES128-GCM-SHA256
 Cipher order
    SSLv3:     Local problem: /usr/bin/openssl doesn't support "s_client -ssl3"
    TLSv1.2:    AES128-GCM-SHA256 AES256-GCM-SHA384 AES256-SHA AES128-SHA AES256-SHA256 AES128-SHA256 ECDHE-RSA-AES128-GCM-SHA256 ECDHE-RSA-AES256-GCM-SHA384 ECDHE-RSA-AES128-SHA ECDHE-RSA-AES256-SHA

Error setting TLSv1.3 ciphersuites
140564736398656:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140096039535936:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:

 Testing server defaults (Server Hello)

 TLS extensions (standard)    "renegotiation info/#65281" "application layer protocol negotiation/#16"
 Session Ticket RFC 5077 hint no -- no lifetime advertised
 SSL Session ID support       yes
 Session Resumption           Tickets no, ID: yes
 TLS clock skew               Random values, no fingerprinting possible
 Signature Algorithm          SHA256 with RSA
 Server key size              RSA 2048 bits
 Server key usage             Digital Signature, Key Encipherment
 Server extended key usage    TLS Web Server Authentication, TLS Web Client Authentication
 Serial                       02C3AD39B5BD0145456C6633539565AB (OK: length 16)
 Fingerprints                 SHA1 D437E87220A0542ED53026F83567A7FF843F14B4
                              SHA256 B7AD550C5D3256950D918E23948A991360A14C68714B4F2FDAD090360FB0561E
 Common Name (CN)             promocionesentutienda.orange.es
 subjectAltName (SAN)         promocionesentutienda.orange.es
 Issuer                       DigiCert SHA2 Secure Server CA (DigiCert Inc from US)
 Trust (hostname)             certificate does not match supplied URI (same w/o SNI)
 Chain of trust               "/root/etc/*.pem" cannot be found / not readable
 EV cert (experimental)       no
 ETS/"eTLS", visibility info  not present
 Certificate Validity (UTC)   expired (2020-11-06 00:00 --> 2021-12-02 23:59)
 # of certificates provided   2
 Certificate Revocation List  http://crl3.digicert.com/ssca-sha2-g7.crl
                              http://crl4.digicert.com/ssca-sha2-g7.crl
 OCSP URI                     http://ocsp.digicert.com
 OCSP stapling                not offered
 OCSP must staple extension   --
 DNS CAA RR (experimental)    not offered
 Certificate Transparency     yes (certificate extension)


 Testing HTTP header response @ "/"

 HTTP Status Code             200 OK
 HTTP clock skew              Got no HTTP time, maybe try different URL?
 Strict Transport Security    not offered
 Public Key Pinning           --
 Server banner                (no "Server" line in header, interesting!)
 Application banner           --
 Cookie(s)                    (none issued at "/")
 Security headers             Cache-Control: no-cache
                              Pragma: no-cache
 Reverse Proxy banner         --


 Testing vulnerabilities

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK), no session ticket extension
 ROBOT                                     Error setting TLSv1.3 ciphersuites
139931121591616:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140256366167360:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140084671284544:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139927807923520:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140383753499968:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139746291180864:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140267828114752:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140247222977856:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140502399817024:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140163419022656:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139815711393088:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                test failed (couldn't connect)
 BREACH (CVE-2013-3587)                    no HTTP compression (OK)  - only supplied "/" tested
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK), no SSLv3 support
 TLS_FALLBACK_SCSV (RFC 7507)              No fallback possible (OK), no protocol below TLS 1.2 offered
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=B7AD550C5D3256950D918E23948A991360A14C68714B4F2FDAD090360FB0561E
 LOGJAM (CVE-2015-4000), experimental      Error setting TLSv1.3 ciphersuites
140714875561280:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
 LUCKY13 (CVE-2013-0169), experimental     Error setting TLSv1.3 ciphersuites
139686851372352:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 RC4 (CVE-2013-2566, CVE-2015-2808)        Local problem: No RC4 Ciphers configured in /usr/bin/openssl


 Testing all 1 locally available ciphers against the server, ordered by encryption strength
 Cipher mapping not available, doing a fallback to openssl

Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits
--------------------------------------------------------------------------

Local problem: couldn't find client simulation data in /root/etc/client-simulation.txt

 Done 2022-10-10 13:37:26 [ 269s] -->> 89.39.182.172:443 (www.ya.com) <<--
```

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

```bash
root@vagrant:~# apt install -y ssh
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  ssh
0 upgraded, 1 newly installed, 0 to remove and 88 not upgraded.
Need to get 5,084 B of archives.
After this operation, 120 kB of additional disk space will be used.
Get:1 http://in.archive.ubuntu.com/ubuntu focal-updates/main amd64 ssh all 1:8.2p1-4ubuntu0.5 [5,084 B]
Fetched 5,084 B in 0s (14.6 kB/s)
Selecting previously unselected package ssh.
(Reading database ... 43316 files and directories currently installed.)
Preparing to unpack .../ssh_1%3a8.2p1-4ubuntu0.5_all.deb ...
Unpacking ssh (1:8.2p1-4ubuntu0.5) ...
Setting up ssh (1:8.2p1-4ubuntu0.5) ...
root@vagrant:~# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa
Your public key has been saved in /root/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:IABLiBgDCHSh3LUNP6fSDwu64+75tdsP3dEm2WV5MsE root@vagrant
The key's randomart image is:
+---[RSA 3072]----+
|#=.o.o       ..  |
|Bo+.. =       E..|
|.o ....+ .    o.+|
|     ...+     ++o|
|     o +S    + + |
|    . o + . . +  |
|   .   o o . .   |
|   .o . o .      |
|  +*o. o....     |
+----[SHA256]-----+
root@vagrant:~# ssh-copy-id vagrant@10.0.2.15
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
vagrant@10.0.2.15's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'vagrant@10.0.2.15'"
and check to make sure that only the key(s) you wanted were added.

root@vagrant:~# ssh-copy-id vagrant@10.0.2.15
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
vagrant@10.0.2.15's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'vagrant@10.0.2.15'"
and check to make sure that only the key(s) you wanted were added.
```
 
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

```bash
root@vagrant:~# mv .ssh/id_rsa .ssh/id_rsa_vagrant
root@vagrant:~# mv .ssh/id_rsa .ssh/id_rsa_vagrant
root@vagrant:~# vim .ssh/config
Host vagrant
        HostName 10.0.2.15
        User vagrant
        port 22
		IdentityFile .ssh/id_rsa_vagrant
~                  
root@vagrant:~# ssh vagrant
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-110-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon 10 Oct 2022 02:08:14 PM UTC

  System load:  1.04               Processes:               138
  Usage of /:   13.0% of 30.63GB   Users logged in:         1
  Memory usage: 25%                IPv4 address for dummy0: 192.168.0.1
  Swap usage:   0%                 IPv4 address for eth0:   10.0.2.15


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Mon Oct 10 14:00:15 2022 from 10.0.2.15
```


7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

```bash
root@vagrant:~# tcpdump -i eth0 -c 100 -w dump.pcap
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
100 packets captured
101 packets received by filter
0 packets dropped by kernel
```
