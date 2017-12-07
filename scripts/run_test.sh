#!/bin/sh

fail () {
  set +ex
  echo "ERROR: $*" >&2
  exit 1
}

[ -z "$1" ] && fail "Pass suites to run as a param. For example 1204-11"

set -ex

cd "$(dirname $0)/.."

scripts/clean.sh
kitchen converge -c 2 $@
kitchen verify -c 2 $@
