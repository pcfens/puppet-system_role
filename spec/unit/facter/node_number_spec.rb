require 'spec_helper'

describe 'node_number fact' do
  subject { Facter.fact(:node_number).value }
  after(:each) { Facter.clear }

  describe 'on a system with a structured hostname' do
    before {
      File.stubs(:exists?).returns false
      Facter.fact(:hostname).stubs(:value).returns 'test-application-prod-00'
    }

    it { should == '00' }
  end

  describe 'on a system without a structured hostname' do
    before {
      Facter.fact(:hostname).stubs(:value).returns 'virtualserver1'
      File.stubs(:exists?).returns false
    }

    it { should == '1' }
  end

  describe 'on a system with a system_role file' do
    before {
      File.stubs(:exists?).returns true
      File.stubs(:open).returns StringIO.new('test-application-prod-10')
    }

    it { should == '10' }
  end
end
