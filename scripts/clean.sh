#!/bin/sh

cd "$(dirname $0)/.."

kitchen destroy
rm -rf Berksfile.lock \
       .bundle \
       .cache \
       Gemfile.lock \
       .kitchen \
       metadata.json \
       vendor \
       policies/*.lock.json \
       commit.txt \
       rspec.xml \
       test/smoke/nodes/*.json
