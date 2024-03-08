#!/bin/bash

NAMESPACE=home-assistant
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../_helpers.sh

create_namespace $NAMESPACE
set_current_namespace $NAMESPACE
kustomize_apply $DIR $@
