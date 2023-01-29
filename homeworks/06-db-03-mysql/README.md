# Домашнее задание к занятию "6.3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

**Ответы:**

```sql
bash-4.4# mysql -u root -p test_db < /data/test_data/test_dump.sql
bash-4.4# mysql -u root -p
mysql> \h
mysql> status
--------------
mysql  Ver 8.0.32 for Linux on aarch64 (MySQL Community Server - GPL)
mysql> use test_db;
Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.02 sec)

mysql> select count(price) from orders where price > 300;
+--------------+
| count(price) |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)
```

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

```sql
CREATE USER 'test' 
    IDENTIFIED WITH mysql_native_password 
    BY 'test-pass'
    WITH MAX_QUERIES_PER_HOUR 100
    PASSWORD EXPIRE INTERVAL 180 DAY
    FAILED_LOGIN_ATTEMPTS 3
    ATTRIBUTE '{"family": "Pretty", "name": "James"}'
;

GRANT SELECT ON test_db TO test;

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE user='test';
+------+------+---------------------------------------+
| USER | HOST | ATTRIBUTE                             |
+------+------+---------------------------------------+
| test | %    | {"name": "James", "family": "Pretty"} |
+------+------+---------------------------------------+
1 row in set (0.01 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

**Ответы:**

```sql
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> show profiles;
+----------+------------+-------------------+
| Query_ID | Duration   | Query             |
+----------+------------+-------------------+
|        1 | 0.00042125 | SET profiling = 1 |
+----------+------------+-------------------+
1 row in set, 1 warning (0.00 sec)

mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> show profiles;
+----------+------------+-----------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                   |
+----------+------------+-----------------------------------------------------------------------------------------+
|        1 | 0.00042125 | SET profiling = 1                                                                       |
|        2 | 0.01011525 | SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db' |
|        3 | 0.04076600 | ALTER TABLE orders ENGINE = MyISAM                                                      |
|        4 | 0.03883875 | ALTER TABLE orders ENGINE = InnoDB                                                      |
+----------+------------+-----------------------------------------------------------------------------------------+
9 rows in set, 1 warning (0.00 sec)

mysql> show profile for  query 3;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000090 |
| Executing hook on transaction  | 0.000007 |
| starting                       | 0.000025 |
| checking permissions           | 0.000006 |
| checking permissions           | 0.000005 |
| init                           | 0.000014 |
| Opening tables                 | 0.000332 |
| setup                          | 0.000183 |
| creating table                 | 0.008548 |
| waiting for handler commit     | 0.000034 |
| waiting for handler commit     | 0.003533 |
| After create                   | 0.001847 |
| System lock                    | 0.000022 |
| copy to tmp table              | 0.000551 |
| waiting for handler commit     | 0.000011 |
| waiting for handler commit     | 0.000015 |
| waiting for handler commit     | 0.000061 |
| rename result table            | 0.000085 |
| waiting for handler commit     | 0.011799 |
| waiting for handler commit     | 0.000056 |
| waiting for handler commit     | 0.001920 |
| waiting for handler commit     | 0.000020 |
| waiting for handler commit     | 0.006524 |
| waiting for handler commit     | 0.000016 |
| waiting for handler commit     | 0.001156 |
| end                            | 0.002796 |
| query end                      | 0.001038 |
| closing tables                 | 0.000011 |
| waiting for handler commit     | 0.000017 |
| freeing items                  | 0.000036 |
| cleaning up                    | 0.000014 |
+--------------------------------+----------+
31 rows in set, 1 warning (0.01 sec)

mysql> show profile for  query 4;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000194 |
| Executing hook on transaction  | 0.000020 |
| starting                       | 0.000027 |
| checking permissions           | 0.000011 |
| checking permissions           | 0.000008 |
| init                           | 0.000016 |
| Opening tables                 | 0.000483 |
| setup                          | 0.000148 |
| creating table                 | 0.005266 |
| After create                   | 0.017525 |
| System lock                    | 0.000357 |
| copy to tmp table              | 0.000203 |
| rename result table            | 0.001586 |
| waiting for handler commit     | 0.000042 |
| waiting for handler commit     | 0.002282 |
| waiting for handler commit     | 0.000014 |
| waiting for handler commit     | 0.006121 |
| waiting for handler commit     | 0.000019 |
| waiting for handler commit     | 0.002493 |
| waiting for handler commit     | 0.000014 |
| waiting for handler commit     | 0.000966 |
| end                            | 0.000497 |
| query end                      | 0.000488 |
| closing tables                 | 0.000006 |
| waiting for handler commit     | 0.000018 |
| freeing items                  | 0.000023 |
| cleaning up                    | 0.000016 |
+--------------------------------+----------+
27 rows in set, 1 warning (0.00 sec)
```


## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

```sql
[mysqld]
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 5G
innodb_log_file_size = 100M
```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
