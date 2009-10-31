require File.join(File.dirname(__FILE__), 'register_hit_type')

module RTurk
  class CreateHIT < RegisterHITType
    attr_accessor :hit_type_id

    def parse(response)
      RTurk::CreateHITResponse.new(response)
    end

    def to_params
      super.merge('HITTypeId' => hit_type_id)
    end

    # More complicated validation run before request
    #
    def validate
      if hit_type_id
        unless question && lifetime
          raise RTurk::MissingParameters, "When you specify a HitTypeID, you must incude a question and lifetime length"
        end
      else
        super # validate as RegisterHitType
      end
    end
  end

  def self.CreateHIT(*args, &blk)
    RTurk::CreateHIT.create(*args, &blk)
  end
end
