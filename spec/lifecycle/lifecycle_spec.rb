require_relative '../../libraries/lifecycle'

describe Lifecycle::Policy do
  let(:policy) do
    Lifecycle::Policy.new
  end

  context 'Simple check' do
    before do
      policy.phases = [:online]

      policy.define_states('foo') do
        online action: 'start', notify: 'reload'
      end

      allow(policy).to receive(:current_phase) { :online }
    end

    it 'returns correct action' do
      expect(policy.action_for('foo')).to eql :start
    end

    it 'returns correct notify' do
      expect(policy.notify_for('foo')).to eql :reload
    end
  end

  context 'Advanced check' do
    before do
      policy.phases = [:online, :offline]

      policy.define_states('foo') do
        online action: 'start', notify: 'reload'
        offline action: 'stop', notify: 'nothing'
      end

      policy.define_states('bar') do
        online action: 'stop', notify: 'restart'
        offline action: 'destroy', notify: 'destroy'  # yes, we support random actions
      end
    end

    context 'online phase' do
      before do
        allow(policy).to receive(:current_phase) { :online }
      end

      it 'returns correct action for foo' do
        expect(policy.action_for('foo')).to eql :start
      end

      it 'returns correct action for bar' do
        expect(policy.action_for('bar')).to eql :stop
      end
    end

    context 'offline phase' do
      before do
        allow(policy).to receive(:current_phase) { :offline }
      end

      it 'returns correct action for foo' do
        expect(policy.action_for('foo')).to eql :stop
      end

      it 'returns correct action for bar' do
        expect(policy.action_for('bar')).to eql :destroy
      end
    end
  end
end
