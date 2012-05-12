require 'dbus'
require 'upstart/dbus/service'

module Upstart
  # Provides access to the system DBus instance.
  class DBus
    def initialize
      @bus = ::DBus::SystemBus.instance
      @main = ::DBus::Main.new
    end

    # Returns a new service object for the given bus name.
    # @param name [String] the requested bus name
    # @return [Upstart::DBus::Service]
    def service(name)
      Upstart::DBus::Service.new(@bus.service(name))
    end

    # Starts the DBus main event loop. This is required for DBus signal
    # handlers to work. It is a blocking call!
    def start
      @main << @bus
      @main.run
    end

    # Stops a running main event loop. Can be used from a system signal handler.
    def stop
      @main.quit
    end
  end
end
