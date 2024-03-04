#!/bin/bash

# Helm command
if command -v microk8s.helm3 &> /dev/null; then
  helm="microk8s.helm3"
elif command -v helm &> /dev/null; then
  helm="helm"
else
  echo "Helm could not be found"
  echo "Trying to install Helm"
  sudo snap install helm --classic
  helm="helm"
fi

# Kubectl command
if command -v microk8s.kubectl &> /dev/null; then
  kubectl="microk8s.kubectl"
elif command -v kubectl &> /dev/null; then
  kubectl="kubectl"
else
  echo "Kubectl could not be found"
  echo "Trying to install Kubectl"
  sudo snap install kubectl --classic
  kubectl="kubectl"
fi

# Kubeseal command
if ! command -v kubeseal &> /dev/null; then
  echo "Kubeseal could not be found"
  KUBESEAL_VERSION='0.26.0' # Set this to, for example, KUBESEAL_VERSION='0.23.0'
  echo "Trying to install Kubeseal v${KUBESEAL_VERSION:?} into /usr/local/bin/kubeseal"
  wget "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION:?}/kubeseal-${KUBESEAL_VERSION:?}-linux-amd64.tar.gz"
  tar -xvzf kubeseal-${KUBESEAL_VERSION:?}-linux-amd64.tar.gz kubeseal
  sudo install -m 755 kubeseal /usr/local/bin/kubeseal
fi

# Check if command is exist or not, if not try to install it
function ensure_installed () {
  program=$1

  if ! command -v $program &> /dev/null
  then
    echo "$program could not be found"
    echo "Trying to install $program"
    sudo apt-get install -y $program
  fi
}

function create_namespace () {
  namespace=${NAMESPACE:-$1}
  $kubectl create namespace $namespace --dry-run=client -o yaml --save-config | $kubectl apply -f -
}

function kubectl_apply () {
  file=$1
  namespace=${NAMESPACE}
  $kubectl apply --namespace $namespace -f $file
}


function kubectl_delete () {
  file=$1
  namespace=${NAMESPACE}
  $kubectl delete --namespace $namespace -f $file
}

function kustomize_apply () {
  location=$1
  args=${@:2}
  helmcmd=$helm

  # Contains --delete flag
  if [[ " ${args[@]} " =~ " --delete " ]]; then
    $kubectl kustomize \
      --enable-helm \
      --helm-command=$helmcmd \
      $location | $kubectl delete -f -
    return
  fi

  $kubectl kustomize \
    --enable-helm \
    --helm-command=$helmcmd \
    $location | $kubectl apply -f -
}

function set_current_namespace () {
  name=$1
  $kubectl config set-context --current --namespace=$name
  current=$($kubectl config view --minify --output 'jsonpath={..namespace}')
  echo Current namespace: $current
}

function set_working_dir () {
  cd "$(dirname "$1")"
  echo Current working directory: $(pwd)
}

# source _helpers.sh
# kubeseal_secret_create secret_name key value file
function kubeseal_secret_create () {
  set -x
  secret_name=$1
  key=$2
  value=$3
  file=$4
  kubeseal_namespace=${KUBESEAL_NAMESPACE:-kubeseal}

  set +x

  if [ -z "$secret_name" ] || [ -z "$key" ] || [ -z "$value" ] || [ -z "$file" ]; then
    echo "Usage: kubeseal_secret_create key value file"
    return
  fi

  set -x

  # File exists
  if [ ! -f $file ]; then
    echo -n $value \
      | kubectl create secret generic $secret_name --dry-run=client --from-file=$key=/dev/stdin -o yaml \
      | kubeseal --format yaml --controller-namespace $kubeseal_namespace > $file
  else
    echo -n $value \
      | kubectl create secret generic $secret_name --dry-run=client --from-file=$key=/dev/stdin -o yaml \
      | kubeseal --format yaml --controller-namespace $kubeseal_namespace  --merge-into=$file
  fi


  if [ $? -ne 0 ]; then
    echo "Error creating secret"
    return
  fi

  echo "Updated $file"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

  if [ -z "$1" ]; then
    echo "Usage: source _helpers.sh <command>"
    echo ""
    echo "Commands:"
    echo "  kubeseal_secret_create <secret_name> <key> <value> <file>"
    exit 0
  fi

  # ./_helpers.sh kubeseal_secret_create key value file
  if [ "$1" == "kubeseal_secret_create" ]; then
    kubeseal_secret_create $2 $3 $4 $5
    exit 0
  fi

fi

