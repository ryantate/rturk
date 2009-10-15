module RTurk
  module Credentials
    
    SANDBOX = 'http://mechanicalturk.sandbox.amazonaws.com/'
    PRODUCTION = 'http://mechanicalturk.amazonaws.com/'

    attr_reader :access_key, :secret_key, :host

    def initialize(access_key, secret_key, opts ={})
      @access_key = access_key
      @secret_key = secret_key
      @host = opts[:sandbox] ? SANDBOX : PRODUCTION
    end

  end
end