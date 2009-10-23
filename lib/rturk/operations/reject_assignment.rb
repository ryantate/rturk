module RTurk
  class RejectAssignment < Operation

    operation 'RejectAssignment'
    
    def parse(xml)
      RTurk::RejectAssignmentResponse.new(xml).balance
    end
    
  end
  def self.RejectAssignment
    RTurk::RejectAssignment.create
  end

end