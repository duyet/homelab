#!/bin/bash

source "$(cd -P "$(dirname "$0")" && pwd)"/../namespace.sh

# Install CRDs
kubectl_apply https://github.com/Altinity/clickhouse-operator/raw/master/deploy/helm/crds/CustomResourceDefinition-clickhouseinstallations.clickhouse.altinity.com.yaml
kubectl_apply https://github.com/Altinity/clickhouse-operator/raw/master/deploy/helm/crds/CustomResourceDefinition-clickhouseinstallationtemplates.clickhouse.altinity.com.yaml
kubectl_apply https://github.com/Altinity/clickhouse-operator/raw/master/deploy/helm/crds/CustomResourceDefinition-clickhouseoperatorconfigurations.clickhouse.altinity.com.yaml

# Helm repo
$helm repo add clickhouse-operator https://docs.altinity.com/clickhouse-operator/
$helm install clickhouse-operator clickhouse-operator/altinity-clickhouse-operator -f values.yaml -n $NAMESPACE
