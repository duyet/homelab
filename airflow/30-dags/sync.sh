#!/bin/bash

set -x
NAMESPACE=${NAMESPACE:-airflow}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../../_helpers.sh

# Change working directory to the directory of this script
set_working_dir $0

POD=$($kubectl get pods -n $NAMESPACE | grep airflow-scheduler | awk '{print $1}')
NUM_FILES=$(ls -1 *.py 2>/dev/null | wc -l)
echo Copying $NUM_FILES dag\(s\) to $POD:/opt/airflow/dags

$kubectl -c scheduler -n $NAMESPACE cp *.py $POD:/opt/airflow/dags

echo Done
