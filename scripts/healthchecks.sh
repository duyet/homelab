#!/bin/bash

set -x

ds=$(date "+%Y-%m-%d %H:%M:%S")
free=$(free -h)
df=$(df -h | grep -v microk8s)

data="ds: $ds
---
free:
$free
---
df:
$df"

curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/7d0527e3-9b98-4460-b0f2-60945222edc4 -d "$data"
