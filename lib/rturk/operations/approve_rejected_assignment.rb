module RTurk
  class ApproveRejectedAssignment < Operation

    attr_accessor :assignment_id, :feedback
    require_params :assignment_id

    def to_params
      {'AssignmentId' => self.assignment_id,
        'RequesterFeedback' => self.feedback}
    end
  end

  def self.ApproveRejectedAssignment(*args)
    RTurk::ApproveRejectedAssignment.create(*args)
  end
end
