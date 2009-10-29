# Parses the GetHIT Response
#
# <?xml version="1.0"?>
# <GetHITResponse>
#   <OperationRequest>
#     <RequestId>49341251-fcbd-45c3-ab98-8fbe2e4d8060</RequestId>
#   </OperationRequest>
#   <HIT>
#     <Request>
#       <IsValid>True</IsValid>
#     </Request>
#     <HITId>GR4R3HY3YGBZXDCAPJWZ</HITId>
#     <HITTypeId>YGKZ2W5X6YFZ08ZRXXZZ</HITTypeId>
#     <CreationTime>2009-06-25T04:21:17Z</CreationTime>
#     <Title>Write a twitter update</Title>
#     <Description>Simply write a twitter update for me</Description>
#     <Question>&lt;ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd"&gt;
#   &lt;ExternalURL&gt;http://s3.amazonaws.com/mpercival.com/newtweet.html?id=foo&lt;/ExternalURL&gt; 
#   &lt;FrameHeight&gt;400&lt;/FrameHeight&gt;
# &lt;/ExternalQuestion&gt;
# </Question>
#     <Keywords>twitter, blogging, writing, english</Keywords>
#     <HITStatus>Reviewable</HITStatus>
#     <MaxAssignments>1</MaxAssignments>
#     <Reward>
#       <Amount>0.10</Amount>
#       <CurrencyCode>USD</CurrencyCode>
#       <FormattedPrice>$0.10</FormattedPrice>
#     </Reward>
#     <AutoApprovalDelayInSeconds>3600</AutoApprovalDelayInSeconds>
#     <Expiration>2009-06-25T05:21:17Z</Expiration>
#     <AssignmentDurationInSeconds>3600</AssignmentDurationInSeconds>
#     <NumberOfSimilarHITs>0</NumberOfSimilarHITs>
#     <RequesterAnnotation>OptionalNote</RequesterAnnotation>
#     <QualificationRequirement>
#       <QualificationTypeId>000000000000000000L0</QualificationTypeId>
#       <Comparator>GreaterThan</Comparator>
#       <IntegerValue>90</IntegerValue>
#       <RequiredToPreview>0</RequiredToPreview>
#     </QualificationRequirement>
#     <HITReviewStatus>NotReviewed</HITReviewStatus>
#   </HIT>
# </GetHITResponse>

module RTurk
  
  class GetHITResponse < Response
    
    attr_accessor :id, :type_id, :status, :title, :description, :reward, :assignments
    attr_accessor :similar_hits, :review_status, :expires_at, :auto_approval
    
    def initialize(response)
      @raw_xml = response
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//HIT'),
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
    
  end
  
end