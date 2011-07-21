require 'overwatch/cli/command'

module Overwatch
  module CLI
    module Command
      
      def self.load
        Dir[File.join(File.dirname(__FILE__), "command", "*.rb")].each do |file|
          require file
        end
        # Overwatch::CLI::Plugin.load!
      end

      def self.commands
        @@commands ||= {}
      end

      def self.command_aliases
        @@command_aliases ||= {}
      end

      def self.namespaces
        @@namespaces ||= {}
      end

      def self.register_command(command)
        commands[command[:command]] = command
      end

      def self.register_namespace(namespace)
        namespaces[namespace[:name]] = namespace
      end

      def self.current_command
        @current_command
      end

      def self.current_args
        @current_args
      end

      def self.current_options
        @current_options
      end

      def self.global_options
        @global_options ||= []
      end

      def self.global_option(name, *args)
        global_options << { :name => name, :args => args }
      end
      
    end
  end
end