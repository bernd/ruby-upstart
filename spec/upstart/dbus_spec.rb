require 'spec_helper'
require 'upstart/dbus'

describe Upstart::DBus, :integration => true do
  let(:bus) { described_class.new }
  let(:mainloop) { double('Main').as_null_object }

  before { ::DBus::Main.stub(:new).and_return(mainloop) }

  describe "#service" do
    it "returns an Upstart::DBus::Service object" do
      bus.service('com.ubuntu.Upstart').should be_a(Upstart::DBus::Service)
    end

    it "returns an instance of the given service" do
      bus.service('com.ubuntu.Upstart').name.should == 'com.ubuntu.Upstart'
    end
  end

  describe "#start" do
    it "adds the bus to the main event loop" do
      mainloop.should_receive(:<<).with(::DBus::SystemBus.instance)

      bus.start
    end

    it "starts the blocking main event loop" do
      mainloop.should_receive(:run)

      bus.start
    end
  end

  describe "#stop" do
    it "calls quit on the mainloop" do
      mainloop.should_receive(:quit)

      bus.stop
    end
  end
end
