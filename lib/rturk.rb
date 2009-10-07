module RTurk
  require 'logger'
  
  class << self
    def logger=(logger_obj)
      @logger = logger_obj
    end

    def logger
      if @logger
        @logger
      else
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::INFO
      end
      @logger
    end

    def log_level=(level=Logger::INFO)
      logger.level = level
    end
  end

end

$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rturk/utilities'
require 'rturk/macros'
require 'rturk/answer'
require 'rturk/external_question_builder'
require 'rturk/requester'
require 'rturk/response'
require 'rturk/operation'
require 'rturk/qualifications'
require 'rturk/question'
require 'rturk/operations/hit'
