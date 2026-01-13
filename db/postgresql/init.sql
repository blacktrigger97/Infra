CREATE ROLE superset LOGIN PASSWORD 'abcd1234' \gexec
-- CREATE ROLE kafka LOGIN PASSWORD 'abcd1234' \gexec
CREATE ROLE airflow LOGIN PASSWORD 'abcd1234' \gexec

SELECT 'CREATE DATABASE bdc' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bdc')\gexec

GRANT CONNECT ON DATABASE bdc TO superset \gexec
-- GRANT CONNECT ON DATABASE bdc TO kafka \gexec
GRANT CONNECT ON DATABASE bdc TO airflow \gexec

\c bdc \gexec

CREATE SCHEMA IF NOT EXISTS nessie \gexec

-- CREATE SCHEMA IF NOT EXISTS kafka \gexec

CREATE SCHEMA IF NOT EXISTS airflow \gexec

CREATE SCHEMA IF NOT EXISTS runlogs \gexec

CREATE SCHEMA IF NOT EXISTS superset \gexec

-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA hue TO hue \gexec
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA hue TO hue \gexec
-- GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA hue TO hue \gexec

-- ALTER DEFAULT PRIVILEGES IN SCHEMA hue GRANT ALL PRIVILEGES ON TABLES TO hue;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA hue GRANT ALL PRIVILEGES ON SEQUENCES TO hue;

GRANT ALL ON SCHEMA superset TO superset \gexec
-- GRANT ALL ON SCHEMA kafka TO kafka \gexec
GRANT ALL ON SCHEMA airflow TO airflow \gexec

ALTER USER superset SET search_path = superset \gexec
-- ALTER USER kafka SET search_path = kafka \gexec
ALTER USER airflow SET search_path = airflow \gexec

REVOKE ALL ON SCHEMA public FROM public \gexec

