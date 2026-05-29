-- CREATE ROLES

CREATE ROLE hue LOGIN PASSWORD 'abcd1234' \gexec

CREATE ROLE airflow LOGIN PASSWORD 'abcd1234' \gexec

CREATE ROLE cfgloghndlr LOGIN PASSWORD 'abcd1234' \gexec


-- Grant Access to bdc database to roles above

SELECT 'CREATE DATABASE bdc' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bdc')\gexec

GRANT CONNECT ON DATABASE bdc TO hue \gexec

GRANT CONNECT ON DATABASE bdc TO airflow \gexec

GRANT CONNECT ON DATABASE bdc TO polaris \gexec

GRANT CONNECT ON DATABASE bdc TO cfgloghndlr \gexec


-- USE BDC DATABASE

\c bdc \gexec


-- CREATE SCHEMAs

CREATE SCHEMA IF NOT EXISTS controls \gexec

CREATE SCHEMA IF NOT EXISTS airflow \gexec

CREATE SCHEMA IF NOT EXISTS runlogs \gexec

CREATE SCHEMA IF NOT EXISTS hue \gexec


-- GRANT ALL PERMISSION ON SCHEMA

GRANT ALL ON SCHEMA hue TO hue \gexec

GRANT ALL ON SCHEMA airflow TO airflow \gexec

GRANT ALL ON SCHEMA controls TO cfgloghndlr \gexec

GRANT ALL ON SCHEMA runlogs TO cfgloghndlr \gexec


-- Set search path for roles

ALTER USER hue SET search_path = hue \gexec

ALTER USER airflow SET search_path = airflow \gexec


-- REVOKE ALL PERMISSIONS FROM PUBLIC SCHEMA

REVOKE ALL ON SCHEMA public FROM public \gexec


-- CONNECTION LIMIT

-- ALTER ROLE hue CONNECTION LIMIT 2 \gexec

-- ALTER ROLE airflow CONNECTION LIMIT 2 \gexec

-- ALTER ROLE cfgloghndlr CONNECTION LIMIT 10 \gexec

-- ALTER ROLE root CONNECTION LIMIT 2 \gexec
