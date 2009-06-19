require 'rubygems'
require 'cgi'
require 'digest/sha1'
require 'base64'
require 'time'
require 'base64'
require 'digest/sha1'
require 'restclient'
require 'xmlsimple'

module RTurk
  class Requester
    include RTurk::Utilities 
    include RTurk::Actions

    SANDBOX = 'http://mechanicalturk.sandbox.amazonaws.com/'
    PRODUCTION = 'http://mechanicalturk.amazonaws.com/'

    attr_reader :access_key, :secret_key, :host

    def initialize(access_key, secret_key, opts ={})
      @access_key = access_key
      @secret_key = secret_key
      @host = opts[:sandbox] ? SANDBOX : PRODUCTION
    end
    
    def raw_request(params = {})
      params = stringify_keys(params)
      base_params = {
        'Service'=>'AWSMechanicalTurkRequester',
        'AWSAccessKeyId' => self.access_key,
        'Timestamp' => Time.now.iso8601,
        'Version' => '2008-08-02'
      }

      params.merge!(base_params)
      signature = sign(params['Service'], params['Operation'], params["Timestamp"])
      params['Signature'] = signature
      querystring = params.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&') # order doesn't matter for the actual request

      response = RestClient.get("#{self.host}?#{querystring}")
    end

    def request(params = {})
      response = self.raw_request(params)
      XmlSimple.xml_in(response.to_s, {'ForceArray' => false})
    end

    def method_missing(method, opts)
      method = method.to_s
      method = method[0,1].upcase + method[1,method.size-1]
      opts.merge!(:Operation => method)
      request(opts)
    end

    private

    def sign(service,method,time)
      msg = "#{service}#{method}#{time}"
      return hmac_sha1( self.secret_key, msg )
    end



    def hmac_sha1(key, s)
      ipad = [].fill(0x36, 0, 64)
      opad = [].fill(0x5C, 0, 64)
      key = key.unpack("C*")
      key += [].fill(0, 0, 64-key.length) if key.length < 64

      inner = []
      64.times { |i| inner.push(key[i] ^ ipad[i]) }
      inner += s.unpack("C*")

      outer = []
      64.times { |i| outer.push(key[i] ^ opad[i]) }
      outer = outer.pack("c*")
      outer += Digest::SHA1.digest(inner.pack("c*"))

      return Base64::encode64(Digest::SHA1.digest(outer)).chomp
    end


  end
end

