# Operation to revoke a qualification from a worker

module RTurk
  class RevokeQualification < Operation
    attr_accessor :qualification_type_id, :subject_id, :reason
    require_params :qualification_type_id, :subject_id

    def to_params
      params = {
        'QualificationTypeId' => qualification_type_id,
        'SubjectId' => subject_id
      }
      params['Reason'] = reason unless reason.nil?
      params
    end
  end

  def self.RevokeQualification(*args)
    RTurk::RevokeQualification.create(*args)
  end
end