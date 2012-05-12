require 'spec_helper'
require 'upstart/dbus/object'


# Extend the ::DBus::Connection class to allow acces to the signal handler
# registry. Used to check correct signal handler registration.
module DBus
  class Connection
    attr_reader :signal_matchrules
  end
end

describe Upstart::DBus::Object, :integration => true do
  let(:bus) { ::DBus::SystemBus.instance }
  let(:service) { bus.service('com.ubuntu.Upstart') }
  let(:object) { described_class.new(service.object('/com/ubuntu/Upstart'), 'com.ubuntu.Upstart0_6') }

  it "should be introspected" do
    object.should be_introspected
  end

  context "with an unknown interface" do
    it "raises an UnknownInterface error" do
      expect {
        described_class.new(service.object('/com/ubuntu/Upstart'), '__unknown_iface')
      }.to raise_error(Upstart::DBus::Object::UnknownInterface)
    end
  end

  describe "#path" do
    it "returns the object path" do
      object.path.should == '/com/ubuntu/Upstart'
    end
  end

  describe "#[]" do
    it "returns the property value for the given key" do
      object['version'].should =~ /init \(upstart/
    end

    context "with a symbol key" do
      it "returns the property value for the given key" do
        object[:version].should =~ /init \(upstart/
      end
    end
  end

  describe "#send_method" do
    it "executes the given method" do
      object.send_method(:GetAllJobs).flatten.first.should =~ %r{/com/ubuntu/Upstart}
    end

    context "with a non-existent method" do
      it "raises an UnknownMethod error" do
        expect {
          object.send_method(:___foo)
        }.to raise_error(Upstart::DBus::Object::UnknownMethod)
      end
    end
  end

  describe "#on_signal" do
    it "creates a signal handler for the given signal" do
      object.on_signal(:JobAdded) {|path| 'jo' }

      bus.signal_matchrules.should_not be_empty
    end

    it "returns self" do
      object.on_signal(:JobAdded) {|p|}.should == object
    end

    context "without a block" do
      it "raises a MissingBlock error" do
        expect {
          object.on_signal(:JobAdded)
        }.to raise_error(Upstart::DBus::Object::MissingBlock)
      end
    end
  end
end
