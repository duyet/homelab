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
