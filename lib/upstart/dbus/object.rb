require 'dbus'

module Upstart
  class DBus
    # Provides access to a DBus object.
    class Object
      # Exception for unknown object interfaces.
      class UnknownInterface < StandardError; end
      # Exception for unknown object methods.
      class UnknownMethod < StandardError; end
      # Exception for missing blocks in object signal handlers.
      class MissingBlock < StandardError; end

      # Creates a new {Upstart::DBus::Object} instance. It raises a
      # {Upstart::DBus::Object::UnknownInterface} error if the given interface
      # does not exists for the object.
      #
      # @param object [::DBus::ProxyObject] DBus proxy object
      # @param interface [String] object interface to be used
      # @return [Upstart::DBus::Object] new instance
      def initialize(object, interface)
        @interface = interface
        @object = object
        @object.default_iface = interface
        @object.introspect

        # Check if the given interface exists.
        unless @object.has_iface?(@interface)
          raise(UnknownInterface, "Interface '#{@interface}' does not exist.")
        end
      end

      # Returns true if the object got introspected.
      def introspected?
        !!@object.introspected
      end

      # Returns the path of the object.
      #
      # @example
      #   object.path #=> "/com/ubuntu/Upstart"
      #
      # @return [String] the path string
      def path
        @object.path.to_s
      end

      # Returns the DBus property value for the given key.
      #
      # @example
      #   object['version'] #=> "init (upstart 0.6.5)"
      #   object[:version] #=> "init (upstart 0.6.5)"
      #
      # @param key (String, Symbol) property key
      # @return [String] property value
      def [](key)
        @object[@interface][key.to_s]
      end

      # Send the given method to the DBus service object.
      #
      # @example
      #   object.send_method(:GetAllJobs) #=> [["/com/ubuntu/Upstart/jobs/alsa_2dmixer_2dsave", ...]]
      #
      # @param name [String, Symbol] DBus method name
      # @return [String, Array, ...] method return value
      def send_method(name)
        @object.send(name)
      rescue NoMethodError
        raise UnknownMethod, "Method '#{name}' does not exist."
      end

      # Creates a signal handler for the DBus object. Requires a block.
      #
      # @example
      #   object.on_signal(:JobAdded) do |job_path|
      #     job_path #=> "/com/ubuntu/Upstart/jobs/alsa_2dmixer_2dsave"
      #   end
      #
      # @param signal [String, Symbol] signal name
      # @return [Upstart::DBus::Object]
      def on_signal(signal, &block)
        raise(MissingBlock, "No block given!") unless block_given?
        @object.on_signal(signal.to_s, &block)
        self
      end
    end
  end
end
