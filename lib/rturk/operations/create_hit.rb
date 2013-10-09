require File.join(File.dirname(__FILE__), 'register_hit_type')

module RTurk
  class CreateHIT < RegisterHITType
    attr_accessor :hit_type_id, :max_assignments, :lifetime, :annotation
    alias_attr :note, :annotation
    alias_attr :assignments, :max_assignments

    def parse(response)
      RTurk::CreateHITResponse.new(response)
    end

    # Gives us access to a question builder attached to this HIT
    #
    # @param [String, Hash] URL Params, if none is passed, simply returns the question
    # @return [RTurk::ExternalQuestion] The question if instantiated or nil
    def question(*args)
      unless args.empty?
        @question ||= RTurk::ExternalQuestion.new(*args)
      else
        @question
      end
    end

    def question_form(text_or_widget)
      if text_or_widget.is_a? Erector::XMLWidget
        @question = text_or_widget
      else
        @question = RTurk::QuestionForm.new(:xml => text_or_widget)
      end
    end

    def to_params
      super.merge(
        'HITTypeId'           => hit_type_id,
        'MaxAssignments'      => (max_assignments || 1),
        'Question'            => question.to_params,
        'LifetimeInSeconds'   => (lifetime || 3600),
        'RequesterAnnotation' => annotation
      )
    end

    # More complicated validation run before request
    #
    def validate
      if hit_type_id
        unless question
          raise RTurk::MissingParameters, "When you specify a HitTypeID, you must incude a question"
        end
      else
        super # validate as RegisterHitType
      end
    end

    def required_fields
      super << :question
    end
  end

  def self.CreateHIT(*args, &blk)
    RTurk::CreateHIT.create(*args, &blk)
  end
end
