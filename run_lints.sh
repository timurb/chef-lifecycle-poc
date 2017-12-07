#!/bin/sh

set -e
set -x

cookstyle --display-cop-names --extra-details
      # --require rubocop/formatter/checkstyle_formatter \
      # --format RuboCop::Formatter::CheckstyleFormatter \
      # --out reports/xml/checkstyle-result.xml
set +x

for VERSION in 11 12 13; do
  set -x
  foodcritic --chef-version "${VERSION}" .
  set +x
done
