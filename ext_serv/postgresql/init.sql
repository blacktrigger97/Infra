SELECT 'CREATE DATABASE nessie_gc' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'nessie_gc')\gexec

SELECT 'CREATE DATABASE hue' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'hue')\gexec

SELECT 'CREATE DATABASE trino' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'trino')\gexec

SELECT 'CREATE DATABASE airflow' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'airflow')\gexec