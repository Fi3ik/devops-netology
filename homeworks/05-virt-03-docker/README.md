##  Задача 1

https://hub.docker.com/repository/docker/fi3ik/public


## Задача 2

--

**Сценарий:**

**- Высоконагруженное монолитное java веб-приложение;** - высоконагруженное приложение лучше размещать в ВМ

**- Nodejs веб-приложение;** - подобного рода приложения идеально ложатся в микроскрвисную архитектуру

**- Мобильное приложение c версиями для Android и iOS;** - думаю, что лучше подойдет докер за счет своей простоты и скорости развертывания

**- Шина данных на базе Apache Kafka;** - для данного типа приложений идеально подходит развертывание в контейнере

**- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;** - видимо зависит от предполагаемой нагрузки, возможны варианты как в контейнере, так и в ВМ

**- Мониторинг-стек на базе Prometheus и Grafana;**- возможно как в ВМ так и в контейнере, но большинстве случае будет достаточно контейнеров

**- MongoDB, как основное хранилище данных для java-приложения;** - зависит от предполагаемой нагрузки, возможны варианты как в контейнере, так и в ВМ

**- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.** - предполагаю, что для данного типа развертываний больше подходит ВМ


## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

```bash
fi3ik@fi3ik-ubuntu:~/projects/docker_net$ docker run -d -t --name debian -v "$(pwd)"/data:/data debian:latest
b9f9093fc49e6875c494c68aea3768fd5bb55c69b2559ba9167d001bd8afdc4b
fi3ik@fi3ik-ubuntu:~/projects/docker_net$ docker run -d -t --name centos -v "$(pwd)"/data:/data centos:latest
3c41085511059c509c9861d0c6070dd3ecf82ab6570981befb0e6425338f00d2
fi3ik@fi3ik-ubuntu:~/projects/docker_net$ docker exec -it centos /bin/bash
[root@3c4108551105 /]# cd /data/
[root@3c4108551105 data]# vi text1
[root@3c4108551105 data]# cat text1 
test text1
[root@3c4108551105 data]# exit
exit
fi3ik@fi3ik-ubuntu:~/projects/docker_net$ vim data/text2
fi3ik@fi3ik-ubuntu:~/projects/docker_net$ cat data/text2
test text2
fi3ik@fi3ik-ubuntu:~/projects/docker_net$ docker exec -it debian /bin/bash
root@b9f9093fc49e:/# cat data/text1
test text1
root@b9f9093fc49e:/# cat data/text2
test text2
root@b9f9093fc49e:/# 


```



