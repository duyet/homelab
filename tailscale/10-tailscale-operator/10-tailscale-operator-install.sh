#!/bin/bash

source "$(cd -P "$(dirname "$0")" && pwd)"/../namespace.sh

# Helm repo
# https://tailscale.com/kb/1236/kubernetes-operator
$helm -n $NAMESPACE repo add tailscale https://pkgs.tailscale.com/helmcharts
$helm repo update

set_working_dir $0
kubectl_apply 20-tailscale-operator-secret.yaml

$helm upgrade \
  --install \
  tailscale-operator \
  tailscale/tailscale-operator \
  --namespace=$NAMESPACE \
  --create-namespace \
  -f values.yaml \
  --wait
