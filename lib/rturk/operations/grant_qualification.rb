# Operation grants a Worker's request for a Qualification.

module RTurk
  class GrantQualification < Operation

    attr_accessor :qualification_request_id, :integer_value
    require_params :qualification_request_id
    
    def to_params
      {'QualificationRequestId' => self.qualification_request_id,
        'IntegerValue' => self.integer_value}
    end
  end
  
  def self.GrantQualification(*args)
    RTurk::GrantQualification.create(*args)
  end

end