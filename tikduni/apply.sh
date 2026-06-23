#!/bin/bash
set -euo pipefail

NAMESPACE=tikduni
RELEASE=tikduni
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/../_helpers.sh"

create_namespace $NAMESPACE

helm upgrade --install "$RELEASE" "$DIR/charts/tikduni" \
  --namespace "$NAMESPACE" \
  --values "$DIR/values-homelab.yaml" \
  "$@"

echo "tikduni deployed to namespace: $NAMESPACE"
$kubectl get pods -n "$NAMESPACE"
