#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../namespace.sh

# Change working directory to the directory of this script
cd "$(dirname "$0")"

# Helm repo
$helm delete airflow -n $NAMESPACE

kubectl_delete 10-airflow-sc.yaml 
kubectl_delete 20-airflow-pvc.yaml
kubectl_delete 30-airflow-secret.yaml

$helm repo remove apache-airflow
