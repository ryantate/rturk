# Parses out the CreateHIT response
#
# Example response:
# <CreateHITResponse>
#   <OperationRequest>
#     <RequestId>ece2785b-6292-4b12-a60e-4c34847a7916</RequestId>
#   </OperationRequest>
#   <HIT>
#     <Request>
#       <IsValid>True</IsValid>
#     </Request>
#     <HITId>GBHZVQX3EHXZ2AYDY2T0</HITId>
#     <HITTypeId>NYVZTQ1QVKJZXCYZCZVZ</HITTypeId>
#   </HIT>
# </CreateHITResponse>

module RTurk
  class CreateHitResponse < Response
    
    def hit_id
      @xml.xpath('//HITId').inner_text
    end
      
    def hit_type_id
      @xml.xpath('//HITTypeId').inner_text
    end
    
    def url
      if RTurk.sandbox?
        "http://workersandbox.mturk.com/mturk/preview?groupId=#{hit_type_id}" # Sandbox Url
      else
        "http://mturk.com/mturk/preview?groupId=#{hit_type_id}" # Production Url
      end
    end
    
  end
end