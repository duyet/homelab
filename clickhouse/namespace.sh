#!/bin/bash

NAMESPACE=clickhouse

source "$(cd -P "$(dirname "$0")" && pwd)"/../utils.sh

create_namespace $NAMESPACE