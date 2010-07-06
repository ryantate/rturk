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
  class AssignmentParser < RTurk::Parser

    attr_reader :assignment_id, :hit_id, :worker_id, :status, :accepted_at,
                :submitted_at, :approved_at, :auto_approval_time

    def initialize(assignment_xml)
      @xml_obj = assignment_xml
      map_content(@xml_obj,
                  :assignment_id => 'AssignmentId',
                  :hit_id => 'HITId',
                  :worker_id => 'WorkerId',
                  :status => 'AssignmentStatus',
                  :accepted_at => 'AcceptTime',
                  :submitted_at => 'SubmitTime',
                  :approved_at => 'ApprovalTime',
                  :auto_approval_time => 'AutoApprovalTime'
                  )
    end

    def answers
      AnswerParser.parse(@xml_obj.xpath('Answer').children)
    end

    # Normalizes a hash of answers that include nested params
    # such as the ones you'll find in Rails
    # Example 'tweet[text]' => 'Tweet!' becomes
    # {'tweet' => {'text' => 'Tweet!'}}
    def normalized_answers
      normalize_nested_params(answers)
    end
  end
end
