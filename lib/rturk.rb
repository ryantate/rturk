module RTurk
  require 'rturk/logger'

  SANDBOX = 'https://mechanicalturk.sandbox.amazonaws.com/'
  PRODUCTION = 'https://mechanicalturk.amazonaws.com/'
  API_VERSION = '2012-03-25' # '2008-08-02'
  OLD_API_VERSION = '2006-05-05'

  class << self
    attr_reader :access_key, :secret_key, :host

    def setup(access_key, secret_key, opts ={})
      @access_key = access_key
      @secret_key = secret_key
      @host = opts[:sandbox] ? SANDBOX : PRODUCTION
    end

    def sandbox?
      @host == SANDBOX
    end

    def logger
      RTurk::Logger.logger
    end
  end
end

require 'rturk/utilities'
require 'rturk/xml_utilities'
require 'rturk/requester'
require 'rturk/operation'
require 'rturk/parser'
Dir.glob(File.join(File.dirname(__FILE__), 'rturk', 'operations', '*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), 'rturk', 'builders', '*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), 'rturk', 'adapters', '*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), 'rturk', 'parsers', '*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), 'rturk', 'parsers', 'responses', '*.rb')).each {|f| require f }

require 'rturk/errors'
