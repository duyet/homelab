#!/bin/bash

helm="microk8s.helm3"
kubectl="microk8s.kubectl"

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
  $kubectl create namespace $namespace && echo "Namespace `$namespace` created" || true
}

function kubectl_apply () {
  file=$1
  namespace=${NAMESPACE}
  $kubectl apply --namespace $namespace -f $file
}

function print_loaded () {
  echo "utils.sh loaded"
}

function print_current_namespace () {
  namespace=$($kubectl config view --minify --output 'jsonpath={..namespace}')
  echo Current namespace: $namespace
}

print_loaded
print_current_namespace
