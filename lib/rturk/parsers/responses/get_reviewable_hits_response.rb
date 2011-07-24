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

    def hit_ids
      @xml.xpath('//HIT').inject([]) do |arr, hit_xml|
        arr << hit_xml.inner_text.strip; arr
      end
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
