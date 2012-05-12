require 'spec_helper'
require 'upstart/dbus/service'

describe Upstart::DBus::Service, :integration => true do
  let(:bus) { ::DBus::SystemBus.instance }

  describe "#object" do
    it "returns an Upstart::DBus::Object object" do
      service = described_class.new(bus.service('com.ubuntu.Upstart'))
      object = service.object('/com/ubuntu/Upstart', 'com.ubuntu.Upstart0_6')

      object.should be_a(Upstart::DBus::Object)
      object.path.should == '/com/ubuntu/Upstart'
    end
  end

  describe "#name" do
    it "returns the service name" do
      service = described_class.new(bus.service('com.ubuntu.Upstart'))

      service.name.should == 'com.ubuntu.Upstart'
    end
  end
end
