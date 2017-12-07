#!/bin/sh -e

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

usage() {
  cat << EOF
Usage: $(basename $0) [fast|common|full|OS CHEF]

  * fast   -- run specs only
  * common -- run tests for Ubuntu 12.04 and Chef 11 only
  * full   -- run tests for all Ubuntu and Chef versions

  * OS can be any of 1204 1404 1604
  * CHEF can be any of 11 12 latest

No error reporting is done, the script will just crash.
EOF
  exit 1
}

OS="$1"
CHEF="$2"

[ -z "${OS}" ] && usage ||:

case "${OS}" in
  fast)
    OS=""
    CHEF=""
    ;;
  common)
    OS="1204"
    CHEF="11"
    ;;
  full)
    OS="1204 1404 1604"
    CHEF="11 12 latest"
    ;;
esac

set -e

cd "$(dirname $0)/scripts"

./run_specs.sh

for os in ${OS}; do
  for chef in ${CHEF}; do
    echo "================== Testing on ${os} with Chef ${chef} =================="
    set -x
    ./run_test.sh "${os}-${chef}"
    set +x
    echo "================== Finished testing on ${os} with Chef ${chef} =================="
  done
done
