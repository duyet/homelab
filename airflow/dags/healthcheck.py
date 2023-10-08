import requests
import pendulum
from airflow.decorators import dag, task


@dag(start_date=pendulum.now(), schedule="@hourly", catchup=False)
def healthcheck():
    @task()
    def ping():
        url = "https://hc-ping.com/4e85e6f6-3b8c-44c2-8bc4-cb05b466d02f"
        requests.get(url, timeout=10)


healthcheck()
