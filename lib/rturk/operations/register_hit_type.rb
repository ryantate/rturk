module RTurk
  class RegisterHITType < Operation

    attr_accessor :title, :description, :reward, :currency, :duration, :keywords, :auto_approval_delay
    alias_attr :auto_approval, :auto_approval_delay


    # @param [Symbol, Hash] qualification_key opts The unique qualification key
    # @option opts [Hash] :comparator A comparator and value e.g. :gt => 80
    # @option opts [Boolean] :boolean true or false
    # @option opts [Symbol] :exists A comparator without a value
    # @return [RTurk::Qualifications]
    def qualifications
      @qualifications ||= RTurk::Qualifications.new
    end

    # Returns parameters specific to this instance
    #
    # @return [Hash]
    #   Any class level default parameters get loaded in at
    #   the time of request
    def to_params
      map_params.merge(qualifications.to_params)
    end

    def parse(response)
      RTurk::RegisterHITTypeResponse.new(response)
    end

    # More complicated validation run before request
    #
    def validate
      missing_parameters = []
      required_fields.each do |param|
        missing_parameters << param.to_s unless self.send(param)
      end
      raise RTurk::MissingParameters, "Parameters: '#{missing_parameters.join(', ')}'" unless missing_parameters.empty?
    end

    def required_fields
      [:title, :description, :reward]
    end

    protected
      def map_params
        begin
          keyword_string = keywords.join(', ')
        rescue NoMethodError
          keyword_string = keywords.to_s
        end

        { 'Title'=>title,
          'Description' => description,
          'AssignmentDurationInSeconds' => (duration || 86400),
          'Reward.Amount' => reward,
          'Reward.CurrencyCode' => (currency || 'USD'),
          'Keywords' => keyword_string,
          'AutoApprovalDelayInSeconds' => auto_approval_delay }
      end
  end

  def self.RegisterHITType(*args, &blk)
    RTurk::RegisterHITType.create(*args, &blk)
  end
end
