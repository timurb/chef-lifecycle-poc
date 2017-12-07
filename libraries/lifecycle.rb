#
# Glossary (naming suggestions are welcome):
#  * operation - operation for service, can be :action, :notify (unchecked)
#  * phase - lifecycle phase, like :online, :offline (can be defined by user)
#  * state - operations for service for given phase
#  * policy - mappings of phases into states for all services
#
require_relative 'lifecycle/service'
require_relative 'lifecycle/policy'
