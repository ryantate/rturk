# Operation to update a qualification score

module RTurk
  class UpdateQualificationScore < Operation
    attr_accessor :qualification_type_id, :subject_id, :integer_value
                  require_params :qualification_type_id, :subject_id

    def parse(xml)
      RTurk::GetQualificationScoreResponse.new(xml)
    end

    def to_params
      params = {
        'QualificationTypeId' => qualification_type_id,
        'SubjectId' => subject_id
      }
      params['IntegerValue'] = integer_value unless integer_value.nil?
      params
    end
  end

  def self.UpdateQualificationScore(*args)
    RTurk::UpdateQualificationScore.create(*args)
  end
end
