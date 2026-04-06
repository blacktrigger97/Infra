-- CREATE ROLES

CREATE ROLE hue LOGIN PASSWORD 'abcd1234' \gexec

CREATE ROLE airflow LOGIN PASSWORD 'abcd1234' \gexec


SELECT 'CREATE DATABASE bdc' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bdc')\gexec

GRANT CONNECT ON DATABASE bdc TO hue \gexec

GRANT CONNECT ON DATABASE bdc TO airflow \gexec


-- USE BDC DATABASE

\c bdc \gexec


-- CREATE SCHEMAs

-- CREATE SCHEMA IF NOT EXISTS nessie \gexec

CREATE SCHEMA IF NOT EXISTS airflow \gexec

CREATE SCHEMA IF NOT EXISTS runlogs \gexec

CREATE SCHEMA IF NOT EXISTS hue \gexec


--GRANT ALL PERMISSION ON SCHEMA

GRANT ALL ON SCHEMA hue TO hue \gexec

GRANT ALL ON SCHEMA airflow TO airflow \gexec

ALTER USER hue SET search_path = hue \gexec

ALTER USER airflow SET search_path = airflow \gexec


-- REVOKE ALL PERMISSIONS FROM PUBLIC SCHEMA

REVOKE ALL ON SCHEMA public FROM public \gexec

