# Operation to get info about qualification score

module RTurk
  class GetQualificationScore < Operation
    attr_accessor :qualification_type_id, :subject_id
    require_params :qualification_type_id, :subject_id

    def parse(xml)
      RTurk::GetQualificationScoreResponse.new(xml)
    end

    def to_params
      {'QualificationTypeId' => qualification_type_id, 'SubjectId' => subject_id}
    end
  end

  def self.GetQualificationScore(*args)
    RTurk::GetQualificationScore.create(*args)
  end
end
