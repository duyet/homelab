#!/bin/bash

source "$(cd -P "$(dirname "$0")" && pwd)"/../namespace.sh

# Helm repo
$helm -n $NAMESPACE upgrade --install postgres-airflow oci://registry-1.docker.io/bitnamicharts/postgresql -f values.yaml

# Note
echo '
To get the password for "postgres" run:

export POSTGRES_PASSWORD=$(kubectl get secret --namespace airflow postgres-airflow-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
'
