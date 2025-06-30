SELECT 'CREATE DATABASE hue' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'hue')\gexec

SELECT 'CREATE DATABASE trino' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'trino')\gexec

SELECT 'CREATE DATABASE airflow' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'airflow')\gexec

SELECT 'CREATE DATABASE logs' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'logs')\gexec
