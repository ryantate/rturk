require 'rubygems'
require 'cgi'
require 'digest/sha1'
require 'base64'
require 'time'
require 'base64'
require 'digest/sha1'
require 'restclient'
require 'nokogiri'

module RTurk
  class Requester
    include RTurk::Utilities 
    include RTurk::Macros
    
    def initialize(account, key, opts = {})
      
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

    def request(obj)
      if obj.is_a? Hash
        response = self.raw_request(obj)
        response = RTurk::BasicResponse.new(response)
      elsif obj.respond_to?(:to_aws_params)
        response = self.raw_request(obj.to_aws_params)
        obj.respond_to?(:parse) ? 
          obj.parse(response) : RTurk::BasicResponse.new(response)
      end
      response
    end
    
    def environment
      @host.match(/sandbox/) ? 'sandbox' : 'production'
    end

    def method_missing(method, *args, &blk)
      if RTurk::Macros.respond_to?(method)
        RTurk::Macros.send(method, *args)
      elsif macros.include?(method)
        macros[method].call
      elsif RTurk::Operation.defined_operations.include?(method.to_s)
        klass = RTurk::Operation.defined_operations[method.to_s].new(*args, &blk)
        response = request(klass.to_aws_params)
        klass.parse(response)
      else
        request_hash = {:Operation => method}.merge(*args)
        request(request_hash)
      end
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

