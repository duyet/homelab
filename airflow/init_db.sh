. ./start.sh

airflow db migrate

airflow users create \
    --username admin \
    --firstname Duyet \
    --lastname Le \
    --role Admin \
    --email duyet.cs@gmail.com

