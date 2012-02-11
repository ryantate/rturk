# Operation to assign a qualification to a worker

module RTurk
  class AssignQualification < Operation
    attr_accessor :qualification_type_id, :worker_id, :send_notification, :integer_value
    require_params :qualification_type_id, :worker_id

    def to_params
      {'QualificationTypeId' => qualification_type_id,
       'WorkerId' => worker_id,
       'SendNotification' => (!!send_notification).to_s,
       'IntegerValue' => integer_value}
    end
  end

  def self.AssignQualification(*args)
    RTurk::AssignQualification.create(*args)
  end
end