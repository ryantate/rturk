module RTurk
  class CreateHit < Operation
    
    operation 'CreateHIT'

    attr_accessor :title, :keywords, :description, :reward, :currency, :assignments
    attr_accessor :lifetime, :duration, :auto_approval, :note, :hit_type_id

    def qualifications
      @qualifications ||= RTurk::Qualifications.new
    end

    def question(*args)
      unless args.empty?
        @question ||= RTurk::Question.new(*args)
      else
        @question
      end
    end
    
    # Returns parameters specific to this instance
    # Any class level default parameters get loaded in at
    # the time of request
    def to_params
      params = map_params.merge(qualifications.to_params)
    end

    def parse(xml)
      RTurk::CreateHitResponse.new(xml)
    end
    
    # We need some basic checking to see if this hit is valid to send.
    # For example, we shouldn't even bother sending if we are missing required
    # parameters such as a question.
    #
    def validate
      if hit_type_id
        unless question && lifetime
          raise RTurk::MissingParameters, "When you specify a HitTypeID, you must incude a question and lifetime length"
        end
      else
        unless  title && reward && question
          raise RTurk::MissingParameters, "You're missing some required parameters"
        end
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
  def self.CreateHit(*args, &blk)
    RTurk::CreateHit.create(*args, &blk)
  end

end
