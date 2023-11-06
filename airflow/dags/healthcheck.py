import requests
from pendulum import now
from datetime import timedelta
from airflow.decorators import dag, task


@dag(start_date=now(), schedule=timedelta(minutes=10), catchup=False)
def healthcheck():
    @task()
    def ping():
        url = "https://hc-ping.com/4e85e6f6-3b8c-44c2-8bc4-cb05b466d02f"
        requests.get(url, timeout=10)

    ping()


healthcheck()
