module RTurk
  class Operation
    
    class << self
      
      attr_accessor :required_params
      
      def default_params
        @default_params ||= {}
      end
      
      def require_params(*args)
        @required_params ||= []
        @required_params.push(*args)
      end
      
      def operation(op)
        default_params.merge!('Operation' => op)
      end
      
    end
    
    ########################
    ### Instance Methods ###
    ########################
    
    
    def self.create(opts = {}, &blk)
      hit = self.new(opts, &blk)
      hit.request
    end

    def initialize(opts = {})
      opts.each_pair do |k,v|
        if self.respond_to?("#{k.to_sym}=")
          self.send "#{k}=".to_sym, v
        elsif v.is_a?(Array)
          v.each do |a|
            (self.send k.to_s).send a[0].to_sym, a[1]
          end
        elsif self.respond_to?(k.to_sym)
          self.send k.to_sym, v
        end
      end
      yield(self) if block_given?
      self
    end
    
    def default_params
      self.class.default_params
    end

    def parse(xml)
      # Override this in your operation if you like
      RTurk::Response.new(xml)
    end

    def credentials
      RTurk
    end

    def request
      if self.respond_to?(:validate)
        validate
      end
      params = to_params.merge(self.default_params)
      parse(RTurk.Request(credentials.access_key, credentials.secret_key, credentials.host, params))
    end


  end
end
