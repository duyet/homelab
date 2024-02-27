#!/bin/bash
. ../namespace.sh


# Helm
$helm uninstall clickhouse-operator clickhouse-operator/altinity-clickhouse-operator -n $NAMESPACE
$helm repo remove clickhouse-operator https://docs.altinity.com/clickhouse-operator/

# Delete CRDs
$kubectl delete -f https://github.com/Altinity/clickhouse-operator/raw/master/deploy/helm/crds/CustomResourceDefinition-clickhouseinstallations.clickhouse.altinity.com.yaml
$kubectl delete -f https://github.com/Altinity/clickhouse-operator/raw/master/deploy/helm/crds/CustomResourceDefinition-clickhouseinstallationtemplates.clickhouse.altinity.com.yaml
$kubectl delete -f https://github.com/Altinity/clickhouse-operator/raw/master/deploy/helm/crds/CustomResourceDefinition-clickhouseoperatorconfigurations.clickhouse.altinity.com.yaml

$kubectl delete namespace $OPERATOR_NAMESPACE
