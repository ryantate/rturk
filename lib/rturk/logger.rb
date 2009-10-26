require 'logger'

module RTurk
  class Logger
    class << self
      def logger=(logger_obj)
        @logger = logger_obj
      end

      def logger
        unless @logger
          @logger = ::Logger.new(STDOUT)
          @logger.level = ::Logger::INFO
        end
        @logger
      end
    end
  end
  
  def self.Logger(*args)
    RTurk::Logger.logger(*args)
  end
  
end
