#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../namespace.sh

# Helm repo
$helm repo add apache-airflow https://airflow.apache.org
$helm upgrade airflow apache-airflow/airflow -f values.yaml -n $NAMESPACE
