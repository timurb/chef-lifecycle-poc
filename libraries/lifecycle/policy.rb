require_relative 'service'

class Lifecycle
  class Policy
    attr_reader :phases

    def initialize(phases = nil)
      @phases = phases
      @services = {}
    end

    def phases=(arg)
      raise 'Phases cannot be redefined' if @phases
      @phases = arg
    end

    def define_states(service_name, &block)
      service = Lifecycle::Service.new(phases)
      service.states(&block)
      @services[service_name] = service
    end

    def action_for(service)
      @services[service].action_when(current_phase)
    end

    def notify_for(service)
      @services[service].notify_when(current_phase)
    end

    def current_phase
      :default    ### FIXME
    end
  end
end
