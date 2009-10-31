module RTurk
  class RegisterHITType < Operation

    attr_accessor :title, :keywords, :description, :reward, :currency, :assignments
    attr_accessor :lifetime, :duration, :auto_approval, :note

    # @param [Symbol, Hash] qualification_key opts The unique qualification key
    # @option opts [Hash] :comparator A comparator and value e.g. :gt => 80
    # @option opts [Boolean] :boolean true or false
    # @option opts [Symbol] :exists A comparator without a value
    # @return [RTurk::Qualifications]
    def qualifications
      @qualifications ||= RTurk::Qualifications.new
    end

    # Gives us access to a question builder attached to this HIT
    #
    # @param [String, Hash] URL Params, if none is passed, simply returns the question
    # @return [RTurk::Question] The question if instantiated or nil
    def question(*args)
      unless args.empty?
        @question ||= RTurk::Question.new(*args)
      else
        @question
      end
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
      unless  title && reward && question && description
        raise RTurk::MissingParameters, "You're missing some required parameters"
      end
    end

    private

      def map_params
        {'Title'=>self.title,
         'MaxAssignments' => (self.assignments || 1),
         'LifetimeInSeconds'=> (self.lifetime || 3600),
         'AssignmentDurationInSeconds' => (self.duration || 86400),
         'Reward.Amount' => self.reward,
         'Reward.CurrencyCode' => (self.currency || 'USD'),
         'Keywords' => self.keywords,
         'Description' => self.description,
         'Question' => self.question.to_params,
         'RequesterAnnotation' => note}
      end

  end
  def self.RegisterHITType(*args, &blk)
    RTurk::RegisterHITType.create(*args, &blk)
  end
end