# Operation to assign a qualification to a worker

module RTurk
  class AssignQualification < Operation
    attr_accessor :qualification_type_id, :worker_id, :send_notification
    require_params :qualification_type_id, :worker_id

    def to_params
      {'QualificationTypeId' => qualification_type_id,
       'WorkerId' => worker_id,
       'SendNotification' => (!!send_notification).to_s}
    end
  end

  def self.AssignQualification(*args)
    RTurk::AssignQualification.create(*args)
  end
end