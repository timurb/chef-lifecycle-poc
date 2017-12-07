#!/bin/sh

set -e

cd "$(dirname $0)/.."

if [ -z "$CI" ]; then
  rspec --color --format doc 
else
  rspec --format RspecJunitFormatter --out rspec.xml
fi
