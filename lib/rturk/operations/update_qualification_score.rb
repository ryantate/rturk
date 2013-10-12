# Operation to update a qualification score
# http://docs.aws.amazon.com/AWSMechTurk/latest/AWSMturkAPI/ApiReference_UpdateQualificationScoreOperation.html

module RTurk
  class UpdateQualificationScore < Operation
    attr_accessor :qualification_type_id, :qualification_type_score, :subject_id, :integer_value
    require_params :qualification_type_id, :subject_id, :integer_value

    def parse(xml)
      RTurk::GetQualificationScoreResponse.new(xml)
    end

    def to_params
      params = {
        'QualificationTypeId' => qualification_type_id,
        'SubjectId' => subject_id,
        'IntegerValue'=> integer_value
      }
    end
  end

  def self.UpdateQualificationScore(*args)
    RTurk::UpdateQualificationScore.create(*args)
  end
end

