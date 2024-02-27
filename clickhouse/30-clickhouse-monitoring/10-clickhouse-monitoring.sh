#!/bin/bash

source "$(cd -P "$(dirname "$0")" && pwd)"/../namespace.sh

helm repo add duyet https://duyet.github.io/charts

helm install clickhouse-monitoring duyet/clickhouse-monitoring -f values.yaml
