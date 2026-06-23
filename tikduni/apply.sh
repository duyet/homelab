#!/bin/bash
set -euo pipefail

NAMESPACE=tikduni
RELEASE=tikduni
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/../_helpers.sh"

create_namespace $NAMESPACE

# Chart lives in the tikduni app repo — clone or adjust path as needed
CHART_DIR="${TIKDUNI_CHART_DIR:-$HOME/project/tiktok-automation/charts/tikduni}"

if [ ! -d "$CHART_DIR" ]; then
  echo "Chart not found at $CHART_DIR"
  echo "Set TIKDUNI_CHART_DIR or clone: git clone git@github.com:duyet/tikduni.git ~/project/tiktok-automation"
  exit 1
fi

helm upgrade --install "$RELEASE" "$CHART_DIR" \
  --namespace "$NAMESPACE" \
  --values "$DIR/values-homelab.yaml" \
  "$@"

echo "tikduni deployed to namespace: $NAMESPACE"
$kubectl get pods -n "$NAMESPACE"
