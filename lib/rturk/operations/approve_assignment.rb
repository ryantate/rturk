module RTurk
  class ApproveAssignment < Operation

    operation 'ApproveAssignment'
    
    def parse(xml)
      RTurk::Response.new(xml)
    end
    
  end
  def self.ApproveAssignment
    RTurk::ApproveAssignment.create
  end

end