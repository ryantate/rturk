module RTurk
  class Operation

    class << self

      def default_params
        @default_params ||= {}
      end

      def required_params
        @required_params || []
      end

      def require_params(*args)
        @required_params ||= []
        @required_params.push(*args)
      end

      def set_operation(op)
        default_params.merge!('Operation' => op)
      end

      def create(opts = {}, &blk)
        hit = self.new(opts, &blk)
        hit.request
      end

      def alias_attr(new_attr, original)
        alias_method(new_attr, original) if method_defined? original
        new_writer = "#{new_attr}="
        original_writer = "#{original}="
        alias_method(new_writer, original_writer) if method_defined? original_writer
      end

    end

    ########################
    ### Instance Methods ###
    ########################

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

    def to_params
      {}# Override to include extra params
    end

    def request
      if self.respond_to?(:validate)
        validate
      end
      check_params
      params = {'Operation' => self.class.to_s.gsub(/^\w+::/,'')}
      params = params.merge(self.default_params)
      params = to_params.merge(params)
      response = RTurk.Request(params)
      parse(response)
    end

    def check_params
      missing_parameters = []
      self.class.required_params.each do |param|
        if self.respond_to?(param)
          missing_parameters << param.to_s if self.send(param).nil?
        else
          raise MissingParameters, "The parameter '#{param.to_s}' was required and not available"
        end
        raise MissingParameters, "Parameters '#{missing_parameters.join(', ')}' cannot be blank" unless missing_parameters.empty?
      end
    end

  end
end
