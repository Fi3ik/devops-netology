# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql*

**Ответы:**

```sql
root@8b69e7892565:/# su postgres
postgres@8b69e7892565:/$ psql
psql (13.9 (Debian 13.9-1.pgdg110+1))
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \c name_db
postgres=# \dt
postgres=# \d table_name
postgres=# \q
```




## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

```sql
test_database=# select max(avg_width) from pg_stats where tablename = 'orders';
 max
-----
  16
(1 row)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

**Ответы:**

```sql
BEGIN;
--переименование старой таблицы
ALTER TABLE orders RENAME TO temp_orders;
-- Создание новой секционированной таблицы
CREATE TABLE orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0)
	PARTITION BY RANGE (price)
    ;
-- Создание секций
CREATE TABLE orders_1 PARTITION OF orders
    FOR VALUES FROM ('500') TO (MAXVALUE);
CREATE TABLE orders_2 PARTITION OF orders
    FOR VALUES FROM (MINVALUE) TO ('500');
-- Перенос строе из старой таблицы в новую секционированную
INSERT INTO orders (id, title, price) SELECT * FROM temp_orders;
-- Завершение транзакции
COMMIT;
```

Данную задачу можно выполнить несколькими способами:
- Декларативное секционирование;
- Секционирование с использованием наследования.

В свою очередь в секционировании с использованием наследования существует два способа перенаправления добавляемых строк:
- Добавление триггерной функции в главную таблицу;
- Определение на главной таблице правила.

Декларативный способ является наиболее оптимальным с точки зрения производительности, поэту для данного примера я выбрал именно этот способ.

Если рассматривать секционирование с использованием наследования, то здесь предпочтительным был бы способ перенаправления добавляемых с помощью триггерной функции. Ниже пример как можно было бы описать данную функцию.
```sql
CREATE OR REPLACE FUNCTION orders_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF ( NEW.price > 499
        INSERT INTO orders_1 VALUES (NEW.*);
    ELSE (  NEW.price <= 499
        INSERT INTO orders_2 VALUES (NEW.*)
    END IF;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;
```

В следующем примере описано как для решения задачи может выглядеть правило для опередения в главной таблице.

```sql
CREATE RULE order_insert_1 AS ON INSERT TO orders
WHERE (rate > 499)
DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*)

CREATE RULE order_insert_2 AS ON INSERT TO orders
WHERE (rate <= 499)
DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*)

```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

**Ответы:**

```postgres@d53b4ec0c03b:/$ pg_dump test_database > /data/test_database_bkp.sql```


Так как я выбрал способ декларативного разделения, я могу назначить свойства уникальности только на секции, таким образом не получится обеспечить гарантированную уникальность в рамках глобальной таблицы.

```sql
ALTER TABLE orders_1 ADD UNIQUE (title);
ALTER TABLE orders_2 ADD UNIQUE (title);
```
