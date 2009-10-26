require 'time'

module RTurk
  
  # Parses:
  # <Assignment>
  #   <AssignmentId>GYFTRHZ5J3DZREY48WNZE38ZR9RR1ZPMXGWE7WE0</AssignmentId>
  #   <WorkerId>AD20WXZZP9XXK</WorkerId>
  #   <HITId>GYFTRHZ5J3DZREY48WNZ</HITId>
  #   <AssignmentStatus>Approved</AssignmentStatus>
  #   <AutoApprovalTime>2009-08-12T19:21:54Z</AutoApprovalTime>
  #   <AcceptTime>2009-07-13T19:21:40Z</AcceptTime>
  #   <SubmitTime>2009-07-13T19:21:54Z</SubmitTime>
  #   <ApprovalTime>2009-07-13T19:27:54Z</ApprovalTime>
  #   <Answer>
  #     <?xml version="1.0" encoding="UTF-8"?>
  #     <QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd">
  #       <Answer>
  #         <QuestionIdentifier>Question100</QuestionIdentifier>
  #         <FreeText>Move to X.</FreeText>
  #       </Answer>
  #     </QuestionFormAnswers>
  #   </Answer>
  # </Assignment>
  
  class Assignment
    include RTurk::XmlUtilities
    
    attr_accessor :worker_id, :id, :status, :submitted_at, :accepted_at, :approved_at
    attr_reader :answers
    
    def initialize(xml_object)
      map_content(xml_object,
        :id => 'AssignmentId',
        :worker_id => 'WorkerId',
        :status => 'AssignmentStatus',
        :accepted_at => 'AcceptTime',
        :approved_at => "ApprovalTime",
        :submitted_at => 'SubmitTime')
        self.answers = xml_object.xpath('Answer').children.to_s
    end
    
    def approved_at=(time)
      @approved_at = Time.parse(time)
    end
    
    def submitted_at=(time)
      @submitted_at = Time.parse(time)
    end

    def accepted_at=(time)
      @accepted_at = Time.parse(time)
    end
    
    def approve!(feedback = nil)
      RTurk::ApproveAssignment(:assignment_id => self.id, :feedback => feedback)
    end
    
    def reject!(reason)
      RTurk::ApproveAssignment(:assignment_id => self.id, :feedback => reason)
    end
    
    def bonus!(amount, reason)
     RTurk::GrantBonus(:amount, :feedback => reason)
    end
    
    def answers=(answer_xml)
      unless answer_xml.empty?
        @answers = RTurk::Answers.new(answer_xml)
      end
    end
    
  end
  
end