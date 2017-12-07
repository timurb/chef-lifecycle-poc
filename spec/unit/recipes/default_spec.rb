#
# Cookbook:: lifecycle
# Spec:: default
#

require 'spec_helper'

describe 'lifecycle::test' do
  context 'When lifecycle state is "default"' do
    subject { chef_run }
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it { is_expected.to start_service('ntpd') }
  end
end
