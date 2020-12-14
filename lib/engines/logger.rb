# frozen_string_literal: true

require 'dry-inflector'

require 'logging'

# To use this module you simply need to include it and a logger will be
# injected into the class or module
# @example
#   class FooBar
#     include Engines::Logger
#
#     def forbarian
#       logger.debug("What is a foobarian?")
#     end
#   end
#
module Engines
  module Logger
    def self.included(base)
      base.class_eval do
        include Methods
        extend Methods
      end
    end

    module Methods
      protected

      def logger
        __setup if @logger.nil?
        @logger
      end
      module_function :logger


      private

      # Create an appender configured according to the various enviroment variables
      #
      # @return [Logging::Appender]
      def appender
        appender_type = Dry::Inflector.new.camelize(env_with_default('ENGINES_LOG_APPENDER', 'stdout'))

        layout_opts = {
          :pattern => env_with_default('ENGINES_LOG_PATTERN', "%d [%6p] %7l - %8c:%-3L - %m\n"),
          :date_pattern => env_with_default('ENGINES_LOG_DATE_PATTERN', "%Y/%m/%d %H:%M:%S.%3N")
        }

        log_file = ENV['ENGINES_LOG_APPENDER_FILENAME']

        Logging::Appenders.const_get(appender_type).new(log_file, :layout => Logging.layouts.pattern(layout_opts))
      end


      def __setup
        # FIXME: This should go in a Config module
        Logging.logger.root.level = (env_with_default('ENGINES_LOG_LEVEL', "info")).downcase.to_sym
        Logging.logger.root.appenders = appender

        @logger = Logging.logger[(is_a?(Module)) ? name : self.class.name]

        # This is required for line numbers. WARKING: It's expensive
        @logger.caller_tracing = ENV['ENGINES_LOG_TRACE'] || false
      end

      # Read the specified environment variable or use the default
      #
      # @param var [String] the name of the environment variable
      # @param default [String] the default value
      # @return [String] the value of the environment variable of the default
      def env_with_default(var, default)
        ENV[var] || default
      end
    end
  end
end
