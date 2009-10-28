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

module RTurk
  
  class AssignmentParser
    include RTurk::XmlUtilities
    
    attr_accessor :id, :status, :worker_id
    
    def initialize(assignment_xml)
      @xml_obj = assignment_xml
      map_content(@xml_obj,
                  :id => 'AssignmentId',
                  :worker_id => 'WorkerId',
                  :status => 'AssignmentStatus')
    end
    
    def approved_at
      @approved_at = Time.parse(@xml_obj.xpath('ApprovalTime').to_s)
    end

    def submitted_at
      @submitted_at = Time.parse(@xml_obj.xpath('SubmitTime').to_s)
    end

    def accepted_at
      @accepted_at = Time.parse(@xml_obj.xpath('AcceptTime').to_s)
    end
    
    def answers
      AnswerParser.parse(@xml_obj.xpath('Answer').children)
    end
    
  end
  
end