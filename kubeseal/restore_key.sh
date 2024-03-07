#!/bin/bash

set -x

ls -lah *.key

NAMESPACE=kubeseal
kubectl apply -f backup.key

# Restart
kubectl rollout restart deployment -n $NAMESPACE sealed-secrets-controller
