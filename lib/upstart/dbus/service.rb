require 'dbus'
require 'upstart/dbus/object'

module Upstart
  class DBus
    # Wraps a ::DBus::Service object. See http://rubydoc.info/gems/ruby-dbus/DBus/Service
    # for details.
    class Service
      # @param service [::DBus::Service]
      def initialize(service)
        @service = service
      end

      # Returns a DBus object for the given path and interface.
      #
      # @example
      #   service.object('/com/ubuntu/Upstart', 'com.ubuntu.Upstart0_6') #=> Upstart::DBus::Object
      #
      # @param path [String] DBus object path
      # @param interface [String] DBus interface to use
      # @return [Upstart::DBus::Object]
      def object(path, interface)
        Upstart::DBus::Object.new(@service.object(path), interface)
      end

      # Returns the DBus service name.
      #
      # @example
      #   service.name #=> "com.ubuntu.Upstart"
      def name
        @service.name.to_s
      end
    end
  end
end
