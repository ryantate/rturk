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
      
      def request(access_key, secret_key, host, params = {})
        params.delete_if {|k,v| v.nil? }
        params = stringify_keys(params)
        base_params = {
          'Service'=>'AWSMechanicalTurkRequester',
          'AWSAccessKeyId' => access_key,
          'Timestamp' => Time.now.iso8601,
          'Version' => '2008-08-02'
        }

        params.merge!(base_params)
        signature = sign(secret_key, params['Service'], params['Operation'], params["Timestamp"])
        params['Signature'] = signature
        querystring = params.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&') # order doesn't matter for the actual request
        RestClient.get("#{host}?#{querystring}")
        # RestClient.get("http://mechanicalturk.sandbox.amazonaws.com/?Keywords=&Signature=Qvr1i35ofM%2FC5dEj5SwjRB%2FZLGA%3D&Version=2008-08-02&RequesterAnnotation=&AWSAccessKeyId=0W304Z7TWY999N8ZXCG2&Reward.Amount=0.05&Timestamp=2009-10-15T10%3A17%3A27-04%3A00&MaxAssignments=5&Title=Look+at+some+pictures+from+4Chan&Reward.CurrencyCode=USD&Description=&Service=AWSMechanicalTurkRequester&LifetimeInSeconds=33")
        # RestClient.get('http://mechanicalturk.sandbox.amazonaws.com/?Keywords=&Signature=Qvr1i35ofM%2FC5dEj5SwjRB%2FZLGA%3D&Version=2008-08-02&RequesterAnnotation=&AWSAccessKeyId=0W304Z7TWY999N8ZXCG2&Reward.Amount=0.05')
      end

      private

        def sign(secret_key, service,method,time)
          msg = "#{service}#{method}#{time}"
          return hmac_sha1(secret_key, msg )
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
