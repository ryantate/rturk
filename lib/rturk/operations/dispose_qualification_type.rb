# Operation to despose a qualification type

module RTurk
  class DisposeQualificationType < Operation
    attr_accessor :qualification_type_id
    require_params :qualification_type_id

    def to_params
      {'QualificationTypeId' => qualification_type_id}
    end
  end

  def self.DisposeQualificationType(*args)
    RTurk::DisposeQualificationType.create(*args)
  end
end