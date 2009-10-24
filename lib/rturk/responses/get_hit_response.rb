# Parses the GetHIT Response
#
# <HIT>
#   <Request>
#     <IsValid>True</IsValid>
#   </Request>
#   <HITId>ZZRZPTY4ERDZWJ868JCZ</HITId>
#   <HITTypeId>NYVZTQ1QVKJZXCYZCZVZ</HITTypeId>
#   <CreationTime>2009-07-07T00:56:40Z</CreationTime>
#   <Title>Location</Title>
#   <Description>Select the image that best represents</Description>
#   <Question>
#     <QuestionForm xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd">
#       <Question>
#         <QuestionIdentifier>Question100</QuestionIdentifier>
#         <DisplayName>My Question</DisplayName>
#         <IsRequired>true</IsRequired>
#         <QuestionContent>
#           <Binary>
#             <MimeType>
#               <Type>image</Type>
#               <SubType>gif</SubType>
#             </MimeType>
#             <DataURL>http://tictactoe.amazon.com/game/01523/board.gif</DataURL>
#             <AltText>The game board, with "X" to move.</AltText>
#           </Binary>
#         </QuestionContent>
#         <AnswerSpecification><FreeTextAnswer/></AnswerSpecification>
#       </Question> 
#     </QuestionForm>
#   </Question>
#   <HITStatus>Assignable</HITStatus>
#   <MaxAssignments>1</MaxAssignments>
#   <Reward>
#     <Amount>5.00</Amount>
#     <CurrencyCode>USD</CurrencyCode>
#     <FormattedPrice>$5.00</FormattedPrice>
#   </Reward>
#   <AutoApprovalDelayInSeconds>2592000</AutoApprovalDelayInSeconds>
#   <Expiration>2009-07-14T00:56:40Z</Expiration>
#   <AssignmentDurationInSeconds>30</AssignmentDurationInSeconds>
#   <NumberOfSimilarHITs>1</NumberOfSimilarHITs>
#   <HITReviewStatus>NotReviewed</HITReviewStatus>
# </HIT>

module RTurk
  
  class GetHITResponse < Response
    
    attr_accessor :id, :type_id, :status, :title, :description, :reward, :assignments
    attr_accessor :similar_hits, :review_status, :expires_at, :auto_approval
    
    def initialize(response)
      @raw_xml = response
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.children,
        :id => 'HITId',
        :type_id => 'HITTypeId',
        :status => 'HITStatus',
        :title => "Title",
        :description => 'Description',
        :assignments => 'MaxAssignments',
        :similar_hits => 'NumberOfSimilarHITs',
        :review_status => 'HITReviewStatus',
        :expires_at => 'Expiration',
        :auto_approval => 'AutoApprovalDelayInSeconds'
      )
    end
    
    def expires_at=(time)
      @expires_at = Time.parse(time)
    end
    
    def auto_approval=(seconds)
      @auto_approval = seconds.to_i
    end
    
  end
  
end