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
  class CreateHITResponse < Response
    
    def hit_id
      @xml.xpath('//HITId').inner_text
    end
      
    def type_id
      @xml.xpath('//HITTypeId').inner_text
    end
    
    def hit
      RTurk::Hit.new(self.hit_id, self)
    end
    
  end
end