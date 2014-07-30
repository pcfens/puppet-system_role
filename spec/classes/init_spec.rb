require 'spec_helper'
describe 'system_role' do
  context 'with correct parameters' do
    let :params do {
      :application => 'test-application',
      :tier        => 'prod',
      :node_number => 10,
    } end
    it { is_expected.to compile }
    it { is_expected.to contain_class('system_role') }
    it { is_expected.to contain_file('/etc/system_role').with(
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0664',
      )}
  end
  context 'with an invalid tier' do
    let :params do {
      :application => 'test-application',
      :tier        => 'prod-2',
      :node_number => 10,
    } end
    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error)
    end
  end
  context 'with an invalid node_number' do
    let :params do {
      :application => 'test-application',
      :tier        => 'prod',
      :node_number => 'two',
    } end
    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error)
    end
  end
end
