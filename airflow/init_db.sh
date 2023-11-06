. ./env.sh

airflow db migrate

airflow users create \
    --username duyet \
    --firstname Duyet \
    --lastname Le \
    --role Admin \
    --email duyet.cs@gmail.com

