# <GetAssignmentsForHITResult>
#   <Request>
#     <IsValid>True</IsValid>
#   </Request>
#   <NumResults>1</NumResults>
#   <TotalNumResults>1</TotalNumResults>
#   <PageNumber>1</PageNumber>
#   <Assignment>
#     <AssignmentId>GYFTRHZ5J3DZREY48WNZE38ZR9RR1ZPMXGWE7WE0</AssignmentId>
#     <WorkerId>AD20WXZZP9XXK</WorkerId>
#     <HITId>GYFTRHZ5J3DZREY48WNZ</HITId>
#     <AssignmentStatus>Approved</AssignmentStatus>
#     <AutoApprovalTime>2009-08-12T19:21:54Z</AutoApprovalTime>
#     <AcceptTime>2009-07-13T19:21:40Z</AcceptTime>
#     <SubmitTime>2009-07-13T19:21:54Z</SubmitTime>
#     <ApprovalTime>2009-07-13T19:27:54Z</ApprovalTime>
#     <Answer>
#       <?xml version="1.0" encoding="UTF-8"?>
#       <QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd">
#         <Answer>
#           <QuestionIdentifier>Question100</QuestionIdentifier>
#           <FreeText>Move to X.</FreeText>
#         </Answer>
#       </QuestionFormAnswers>
#     </Answer>
#   </Assignment>
# </GetAssignmentsForHITResult>

module RTurk

  class GetAssignmentsForHITResponse < Response

    def assignments
      @assignments ||= []
      @xml.xpath('//Assignment').each do |assignment_xml|
        @assignments << AssignmentParser.new(assignment_xml)
      end
      @assignments
    end

    # todo: test
    def total_num_results
      @xml.xpath('//TotalNumResults').inner_text.to_i
    end

    # todo: test
    def num_results
      @xml.xpath('//NumResults').inner_text.to_i
    end

    # todo: test
    def page_number
      @xml.xpath('//PageNumber').inner_text.to_i
    end


  end

end
