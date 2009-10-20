module RTurk
  
  class GetAssignmentsResponse < Response
    
    def answer
      RTurk::AnswerParser(@xml.xpath('//Answer').children.to_s)
    end
    
  end
  
end