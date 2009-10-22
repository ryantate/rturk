module RTurk
  
  class GetAssignmentsResponse < Response
    include Enumerable
    
    def assignments
      RTurk::Assignments.new(@xml.xpath('//Answer'))
    end
    
  end
  
end