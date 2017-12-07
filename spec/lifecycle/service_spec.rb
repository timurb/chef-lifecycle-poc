require_relative '../../libraries/lifecycle/service'

describe Lifecycle::Service do
  let(:service) do
    Lifecycle::Service.new([:online, :offline])
  end
  subject { service }

  it { is_expected.to respond_to :online }
  it { is_expected.to respond_to :offline }

  context 'register some states' do
    before do
      service.states do
        # default :online   ### FIXME: not implemented
        online action: 'start', notify: 'reload'
        offline action: 'stop', notify: 'restart'
      end
    end

    it 'processes correct actions for online state' do
      expect(service.action_when(:online)).to eql :start
    end

    it 'processes correct notifies for online state' do
      expect(service.notify_when(:online)).to eql :reload
    end

    it 'processes correct actions for offline state' do
      expect(service.action_when(:offline)).to eql :stop
    end
    it 'processes correct notifies for offline state' do
      expect(service.notify_when(:offline)).to eql :restart
    end

    it 'processes correct actions for default state' do
      expect(service.action_when(:default)).to eql :start
    end

    it 'processes correct notifies for default state' do
      expect(service.notify_when(:default)).to eql :reload
    end

    ###
    ### The below behaviour is questionable:
    ###   What should we do when the state is unknown?
    ###   Fail with error or return default value?
    ###   Current behaviour is the latter.
    ###
    it 'processes correct actions for unknown state' do
      expect(service.action_when(:unknown)).to eql :start
    end

    it 'processes correct notifies for unknown state' do
      expect(service.notify_when(:unknown)).to eql :reload
    end
  end
end
