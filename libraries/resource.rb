require_relative 'lifecycle'

class Chef
  class Lifecycle
    class << self
      attr_reader :policy

      def initialize_lifecycle(phases)
        @policy = ::Lifecycle::Policy.new(phases)
      end
    end

    module Helpers
      module Recipe
        def initialize_lifecycle(phases)
          ::Chef::Lifecycle::initialize_lifecycle(phases)
        end

        def lifecycle(name, &block)
          ::Chef::Lifecycle.policy.define_states(name, &block)
        end
      end

      module Service
        def action_for(name)
          ::Chef::Lifecycle.policy.action_for(name)
        end

        def notify_for(name)
          ::Chef::Lifecycle.policy.notify_for(name)
        end
      end
    end
  end
end

::Chef::Recipe.send(:include, ::Chef::Lifecycle::Helpers::Recipe)
::Chef::Resource::Service.send(:include, ::Chef::Lifecycle::Helpers::Service)
