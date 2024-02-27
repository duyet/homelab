#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../namespace.sh

# Change working directory to the directory of this script
cd "$(dirname "$0")"

kubectl_apply 10-airflow-sc.yaml 
kubectl_apply 20-airflow-pvc.yaml
kubectl_apply 30-airflow-secret.yaml

# Helm install
$helm repo add apache-airflow https://airflow.apache.org
$helm upgrade --install airflow apache-airflow/airflow -f values.yaml -n $NAMESPACE

# Sync dags first time
$DIR/30-dags/sync.sh
