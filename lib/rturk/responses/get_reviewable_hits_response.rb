# <GetReviewableHITsResult>
#   <Request>
#     <IsValid>True</IsValid>
#   </Request>
#   <NumResults>3</NumResults>
#   <TotalNumResults>3</TotalNumResults>
#   <PageNumber>1</PageNumber>
#   <HIT>
#     <HITId>GBHZVQX3EHXZ2AYDY2T0</HITId>
#   </HIT>
#   <HIT>
#     <HITId>GBHZVQX3EHXZ2AYDY2T1</HITId>
#   </HIT>
#   <HIT>
#     <HITId>GBHZVQX3EHXZ2AYDY2T2</HITId>
#   </HIT>
# </GetReviewableHITsResult>

module RTurk
  
  class GetReviewableHITsResponse < Response
    
    def hits
      @hits ||= []
      @xml.xpath('//HIT').each do |hit_xml|
        @hits << RTurk::Hit.new(hit_xml.inner_text.strip)
      end
      @hits
    end
    
  end
  
end