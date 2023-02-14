# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

**Ответы:**

- текст Dockerfile манифеста

```dockerfile
FROM centos:7

WORKDIR /opt/elasticsearch

RUN yum -y update && yum install -y \
    wget \
    perl-Digest-SHA \
 && groupadd elasticsearch \
 && useradd elasticsearch -g elasticsearch -p elasticsearch \
 && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.1-linux-x86_64.tar.gz \
 && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.1-linux-x86_64.tar.gz.sha512 \
 && shasum -a 512 -c elasticsearch-8.6.1-linux-x86_64.tar.gz.sha512 \
 && tar -xzf elasticsearch-8.6.1-linux-x86_64.tar.gz \
 && yum remove -y \
    wget \
    perl-Digest-SHA \
 && yum clean all \
 && mkdir /var/lib/data /var/lib/logs /var/lib/snapshots \
 && mv elasticsearch-8.6.1/* . \
 && chown -R elasticsearch:elasticsearch /opt/elasticsearch /var/lib/data /var/lib/logs /var/lib/snapshots \
 && rm -rv elasticsearch-8.6.1/ \
 && rm elasticsearch-8.6.1-linux-x86_64.tar.gz \
 && rm elasticsearch-8.6.1-linux-x86_64.tar.gz.sha512


USER elasticsearch
COPY ./elasticsearch.yml config/

ENTRYPOINT [ "bin/elasticsearch" ]

EXPOSE 9200 9300
```

- ссылку на образ в репозитории dockerhub

https://hub.docker.com/repository/docker/fi3ik/netology_elastic/general

- ответ `elasticsearch` на запрос пути `/` в json виде

```json
ubuntu:/srv/els$ curl http://localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "8Qj0qMQES3yJvLbqJOS-Uw",
  "version" : {
    "number" : "8.6.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "180c9830da956993e59e2cd70eb32b5e383ea42c",
    "build_date" : "2023-01-24T21:35:11.506992272Z",
    "build_snapshot" : false,
    "lucene_version" : "9.4.2",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.


**Ответы:**

- Создание индексов

```http request
curl -X PUT http://localhost:9200/ind-1?pretty -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 1,  
      "number_of_replicas": 0 
    }
  }
}
'
curl -X PUT http://localhost:9200/ind-2?pretty -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 2,  
      "number_of_replicas": 1 
    }
  }
}
'
curl -X PUT http://localhost:9200/ind-3?pretty -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 4,  
      "number_of_replicas": 2 
    }
  }
}
'
```

- Список индексов

```bash
ubuntu:/srv/els$ curl -X GET http://localhost:9200/_cat/indices
green  open ind-1 sJ4aBNJ_TbG6NgxjZAwzaA 1 0 0 0 225b 225b
yellow open ind-3 t_SJ7xDhSXS2HO4taAQvcA 4 2 0 0 900b 900b
yellow open ind-2 fOOSfMuqSQC1BhcaU1JYRw 2 1 0 0 450b 450b
```

- Состояние кластера

```bash
ubuntu:/srv/els$ curl -X GET http://127.0.0.1:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason
.geoip_databases 0 p STARTED
ind-3            0 p STARTED
ind-3            0 r UNASSIGNED INDEX_CREATED
ind-3            0 r UNASSIGNED INDEX_CREATED
ind-3            1 p STARTED
ind-3            1 r UNASSIGNED INDEX_CREATED
ind-3            1 r UNASSIGNED INDEX_CREATED
ind-3            2 p STARTED
ind-3            2 r UNASSIGNED INDEX_CREATED
ind-3            2 r UNASSIGNED INDEX_CREATED
ind-3            3 p STARTED
ind-3            3 r UNASSIGNED INDEX_CREATED
ind-3            3 r UNASSIGNED INDEX_CREATED
ind-2            0 p STARTED
ind-2            0 r UNASSIGNED INDEX_CREATED
ind-2            1 p STARTED
ind-2            1 r UNASSIGNED INDEX_CREATED
ind-1            0 p STARTED
```

- Удаление индексов

```bash
ubuntu:/srv/els$ curl -X DELETE http://localhost:9200/ind-1
ubuntu:/srv/els$ curl -X DELETE http://localhost:9200/ind-2
ubuntu:/srv/els$ curl -X DELETE http://localhost:9200/ind-3
```

Часть индексов в состоянии `yellow` по причине того, что наш кластер состоит всего из одной ноды и индексам `ind-2` и `ind-3` не где размещать часть своих шардов и реплик.


## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`



**Ответы:**

- Создание репозитория
```http request
ubuntu:/srv/els$  curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/opt/elasticsearch/snapshots"
  }
}
'
```
- Создание индекса `test`
```http request
ubuntu:/srv/els$  curl -X PUT http://localhost:9200/test?pretty -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 1,  
      "number_of_replicas": 0 
    }
  }
}
'
```

- Список индексов
```bash
ubuntu:/srv/els$  curl -X GET http://localhost:9200/_cat/indices
green open test 7sB7kk0rRJqjXB5kh2S7zA 1 0 0 0 225b 225b
```


- Создание снэпшота индекса `test`
```http request
ubuntu:/srv/els$ curl -X PUT "http://localhost:9200/_snapshot/netology_backup/%3Ctest_%7Bnow%2Fd%7D%3E?wait_for_completion=true&pretty"
{
  "snapshot" : {
    "snapshot" : "test_2023.02.14",
    "uuid" : "AMl1OtlCTvmgYKfDxejp0w",
    "repository" : "netology_backup",
    "version_id" : 8060199,
    "version" : "8.6.1",
    "indices" : [
      "test",
      ".geoip_databases"
    ],
    "data_streams" : [ ],
    "include_global_state" : true,
    "state" : "SUCCESS",
    "start_time" : "2023-02-14T19:11:56.261Z",
    "start_time_in_millis" : 1676401916261,
    "end_time" : "2023-02-14T19:11:57.262Z",
    "end_time_in_millis" : 1676401917262,
    "duration_in_millis" : 1001,
    "failures" : [ ],
    "shards" : {
      "total" : 2,
      "failed" : 0,
      "successful" : 2
    },
    "feature_states" : [
      {
        "feature_name" : "geoip",
        "indices" : [
          ".geoip_databases"
        ]
      }
    ]
  }
}
```

- Список снэпшотов
```http request
/srv/els$ curl -X GET "http://localhost:9200/_snapshot/netology_backup/_all?pretty"
{
  "snapshots" : [
    {
      "snapshot" : "test_2023.02.14",
      "uuid" : "AMl1OtlCTvmgYKfDxejp0w",
      "repository" : "netology_backup",
      "version_id" : 8060199,
      "version" : "8.6.1",
      "indices" : [
        "test",
        ".geoip_databases"
      ],
      "data_streams" : [ ],
      "include_global_state" : true,
      "state" : "SUCCESS",
      "start_time" : "2023-02-14T19:11:56.261Z",
      "start_time_in_millis" : 1676401916261,
      "end_time" : "2023-02-14T19:11:57.262Z",
      "end_time_in_millis" : 1676401917262,
      "duration_in_millis" : 1001,
      "failures" : [ ],
      "shards" : {
        "total" : 2,
        "failed" : 0,
        "successful" : 2
      },
      "feature_states" : [
        {
          "feature_name" : "geoip",
          "indices" : [
            ".geoip_databases"
          ]
        }
      ]
    }
  ],
  "total" : 1,
  "remaining" : 0
}
```

- Перечень файлов в директории снэпшотов
```bash
ubuntu:/srv/els$ docker exec -it es01 sh -c "ls -la /opt/elasticsearch/snapshots"
total 32
drwxr-xr-x 3 elasticsearch elasticsearch   134 Feb 14 19:11 .
drwxr-xr-x 1 elasticsearch elasticsearch    49 Feb 14 18:42 ..
-rw-r--r-- 1 elasticsearch elasticsearch   848 Feb 14 19:11 index-2
-rw-r--r-- 1 elasticsearch elasticsearch     8 Feb 14 19:11 index.latest
drwxr-xr-x 4 elasticsearch elasticsearch    66 Feb 14 19:11 indices
-rw-r--r-- 1 elasticsearch elasticsearch 18482 Feb 14 19:11 meta-AMl1OtlCTvmgYKfDxejp0w.dat
-rw-r--r-- 1 elasticsearch elasticsearch   359 Feb 14 19:11 snap-AMl1OtlCTvmgYKfDxejp0w.dat
```

- Удаление индекса `test`
```http request
/srv/els$ curl -X DELETE http://localhost:9200/test
{"acknowledged":true
```

- Создание индекса `test-2`
```http request
ubuntu:/srv/els$ curl -X PUT http://localhost:9200/test-2?pretty -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  }
}
'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}
```

- Список индексов
```bash
ubuntu:/srv/els$ curl -X GET http://localhost:9200/_cat/indices
green open test-2 JU-36-N_TYKYbLfo0CmrJQ 1 0 0 0 225b 225b
```

- Восстановление индекса `test`
```bash
ubuntu:/srv/els$ curl -X POST "localhost:9200/_snapshot/netology_backup/test_2023.02.14/_restore?pretty"
{
  "accepted" : true
}
```

- Итоговый список индексов
```bash
ubuntu:/srv/els$ curl -X GET http://localhost:9200/_cat/indices
green open test-2 JU-36-N_TYKYbLfo0CmrJQ 1 0 0 0 225b 225b
green open test   OpWkgDWzTN-f86Zg00R1CA 1 0 0 0 225b 225b
```
