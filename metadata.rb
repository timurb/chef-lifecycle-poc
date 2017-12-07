name 'lifecycle'
maintainer 'Timur Batyrshin'
maintainer_email 'erthad@gmail.com'
license 'MIT'
description 'Installs/Configures lifecycle'
long_description 'Installs/Configures lifecycle'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/timurb/chef-lifecycle-poc/pull-requests'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.

source_url 'https://github.com/timurb/chef-lifecycle-poc'

supports 'ubuntu'
