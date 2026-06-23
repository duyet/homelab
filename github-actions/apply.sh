#!/bin/bash
set -euo pipefail

NAMESPACE=github-actions
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/../_helpers.sh"

create_namespace $NAMESPACE
set_current_namespace $NAMESPACE

echo "NOTE: Ensure the runner secret exists before applying:"
echo "  kubectl create secret generic github-runner-secret \\"
echo "    --namespace $NAMESPACE \\"
echo "    --from-literal=GITHUB_TOKEN=<PAT> \\"
echo "    --dry-run=client -o yaml | kubectl apply -f -"
echo ""

kustomize_apply "$DIR" "$@"

echo ""
echo "Runners deployed. Monitor with:"
echo "  kubectl get pods -n $NAMESPACE -w"
