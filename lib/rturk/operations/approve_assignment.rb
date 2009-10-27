# Operation to approve an assignment
#
# http://mechanicalturk.amazonaws.com/?Service=AWSMechanicalTurkRequester
# &AWSAccessKeyId=[the Requester's Access Key ID]
# &Version=2008-08-02
# &Operation=ApproveAssignment
# &Signature=[signature for this request]
# &Timestamp=[your system's local time]
# &AssignmentId=123RVWYBAZW00EXAMPLE456RVWYBAZW00EXAMPLE

module RTurk
  class ApproveAssignment < Operation

    attr_accessor :assignment_id, :feedback
    require_params :assignment_id
    
    def to_params
      {'AssignmentId' => self.assignment_id,
        'RequesterFeedback' => self.feedback}
    end
    
  end
  def self.ApproveAssignment(*args)
    RTurk::ApproveAssignment.create(*args)
  end

end