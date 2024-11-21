Тестовая обкатка работоспособности Lucee с БД
==============================================

*Проходим ряд этапов*

1) Разворачиваем PostgreSQL
2) Подключаемся к ней и делаем

```sh
ALTER SYSTEM SET password_encryption = 'scram-sha-256';
SELECT pg_reload_conf();

CREATE USER myuser WITH PASSWORD 'password12345';
CREATE DATABASE mydatabase;
ALTER DATABASE mydatabase OWNER TO myuser;
ALTER DATABASE mydatabase SET search_path to mydatabase;
```
2.1) Подключаемся под myuser
```sh
\C mydatabase
CREATE SCHEMA mydatabase
CREATE TABLE check_point (
    id SERIAL PRIMARY KEY,
    value INTEGER NOT NULL
);
INSERT INTO check_point (value)
VALUES (1), (2), (3), (4), (5);
```
3) Находим предварительно LUCEE где можно использовать
```sh
CommandBox> repl
CFSCRIPT-REPL: getInstance('PasswordManager@lucee-password-util').encryptDataSource('password12345')
```
Получаем hash и далее используем в передаче CFM:
Пример CFM ниже
```sh
{ 
  "testds_class": "org.postgresql.Driver",
  "testds_bundleName": "org.postgresql.jdbc", 
  "testds_bundleVersion": "42.6.0", 
  "testds_connectionString": "jdbc:postgresql://postgresql-cl2vzaytsev1.postgresql-cl2vzaytsev1.svc.k8s-2.ext.nubes.ru:5432/mydatabase", 
  "testds_username": "myuser", 
  "testds_password": "encrypted:6e97c7d3441f1b393be2e74a1dbc8e43f88a92be270de6f7405ffce85fd52b1e489643ae147ca352",
  "testds_connectionLimit": "5", 
  "testds_liveTimeout": "15", 
  "testds_validate": "false" 
}
```
