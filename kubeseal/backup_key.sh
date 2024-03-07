#!/bin/bash

set -x

NAMESPACE=kubeseal
kubectl get secret -n $NAMESPACE -l sealedsecrets.bitnami.com/sealed-secrets-key -o yaml > backup.key
echo "---" >> backup.key
kubectl get secret -n $NAMESPACE sealed-secrets-key -o yaml >>backup.key

ls -lah *.key
