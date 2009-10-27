module RTurk
  
  # == Reject Assignment
  # 
  # Operation to reject a workers assignment, requires a reason
  
  class RejectAssignment < Operation

    attr_accessor :assignment_id, :feedback
    require_params :assignment_id, :feedback
    
    def to_params
      {'AssignmentId' => self.assignment_id,
        'RequesterFeedback' => self.feedback}
    end
    
  end
  def self.RejectAssignment(*args)
    RTurk::RejectAssignment.create(*args)
  end

end
