# Operation rejects a user's request for a Qualification

module RTurk
  class RejectQualificationRequest < Operation

    attr_accessor :qualification_request_id, :reason
    require_params :qualification_request_id
    
    def to_params
      {'QualificationRequestId' => self.qualification_request_id,
        'Reason' => self.reason}
    end
  end
  
  def self.RejectQualificationRequest(*args)
    RTurk::RejectQualificationRequest.create(*args)
  end

end