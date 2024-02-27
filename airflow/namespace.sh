#!/bin/bash

NAMESPACE=airflow

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../_helpers.sh

create_namespace $NAMESPACE
