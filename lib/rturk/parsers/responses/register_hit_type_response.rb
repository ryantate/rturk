# Parses out the RegisterHITType response
#
# Example response:
# <RegisterHITTypeResult>
#   <Request>
#     <IsValid>True</IsValid>
#   </Request>
#   <HITTypeId>KZ3GKTRXBWGYX8WXBW60</HITTypeId>
# </RegisterHITTypeResult>

module RTurk
  class RegisterHITTypeResponse < Response
    def type_id
      @xml.xpath('//HITTypeId').inner_text
    end
  end
end