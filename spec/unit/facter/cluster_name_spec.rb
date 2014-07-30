require 'spec_helper'

describe 'cluster_name fact' do
  subject { Facter.fact(:cluster_name).value }
  after(:each) { Facter.clear }

  describe 'on a system with a structured hostname' do
    before {
      File.stubs(:exists?).returns false
      Facter.fact(:hostname).stubs(:value).returns 'test-application-prod-00'
    }

    it { should == 'test-application-prod' }
  end

  describe 'on a system without a structured hostname' do
    before {
      Facter.fact(:hostname).stubs(:value).returns 'virtualserver1'
      File.stubs(:exists?).returns false
    }

    it { should == 'virtualserver' }
  end

  describe 'on a system with a system_role file' do
    before {
      File.stubs(:exists?).returns true
      File.stubs(:open).returns StringIO.new('test-application-prod-10')
    }

    it { should == 'test-application-prod' }
  end
end
