class Lifecycle
  class Service
    def initialize(phases)
      @state = {}
      @default = nil

      phases.each do |phase|
        define_singleton_method(phase) do |state|
          @default ||= phase
          @state[phase] = state   ### FIXME: add validation for action/notify
        end
      end
    end

    def states(&block)
      instance_eval(&block)
    end

    def action_when(phase)
      operation(phase, :action)
    end

    def notify_when(phase)
      operation(phase, :notify)
    end

    private

    def operation(phase, operation)
      phase = real_phase(phase)
      @state[phase][operation].to_sym   ### FIXME: produce something when nil?
    end

    def real_phase(phase)
      if @state[phase].nil? || @state[phase].empty?   ### FIXME: crash when unkwnown?
        @default
      else
        phase
      end
    end
  end
end
