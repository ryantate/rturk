require 'cgi'
require 'digest/sha1'
require 'base64'
require 'time'
require 'base64'
require 'digest/sha1'
require 'restclient'

module RTurk
  class Requester

    class << self
      include RTurk::Utilities
      
      # @param [Hash] params
      # @option [String] 'Operation' The operation - Required
      # @option [String] Any Pass any other params and they will be included in the request
      #
      def request(params = {})
        params.delete_if {|k,v| v.nil? }
        params = stringify_keys(params)
        base_params = {
          'Service'=>'AWSMechanicalTurkRequester',
          'AWSAccessKeyId' => credentials.access_key,
          'Timestamp' => Time.now.iso8601,
          'Version' => RTurk::API_VERSION
        }

        params.merge!(base_params)
        signature = sign(credentials.secret_key, params['Service'], params['Operation'], params["Timestamp"])
        params['Signature'] = signature
        querystring = params.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&') # order doesn't matter for the actual request
        RTurk.logger.debug "Sending request:\n\t #{credentials.host}?#{querystring}"
        RestClient.get("#{credentials.host}?#{querystring}")
      end
      
      def sign(secret_key, service,method,time)
        msg = "#{service}#{method}#{time}"
        return hmac_sha1(secret_key, msg )
      end
      
      private
      
        def credentials
          RTurk
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
  
  def self.Request(*args)
    RTurk::Requester.request(*args)
  end

end
