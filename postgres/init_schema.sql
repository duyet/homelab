-- Duyet
CREATE USER duyet WITH PASSWORD 'duyet';

-- Airflow
CREATE USER airflow WITH PASSWORD 'airflow';
CREATE DATABASE airflow;
ALTER DATABASE airflow OWNER TO airflow;
GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;

-- Grafana
CREATE USER grafana WITH PASSWORD 'grafana';
CREATE DATABASE grafana;
ALTER DATABASE grafana OWNER TO grafana;
GRANT ALL PRIVILEGES ON DATABASE grafana TO grafana;
