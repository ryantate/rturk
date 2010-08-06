# Operation to get info about qualification type

module RTurk
  class GetQualificationType < Operation
    attr_accessor :qualification_type_id
    require_params :qualification_type_id

    def parse(xml)
      RTurk::GetQualificationTypeResponse.new(xml)
    end

    def to_params
      {'QualificationTypeId' => qualification_type_id}
    end
  end

  def self.GetQualificationType(*args)
    RTurk::GetQualificationType.create(*args)
  end
end