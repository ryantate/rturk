module RTurk
  class GetReviewableHits < Operation

    operation 'GetReviewableHITs'
    attr_accessor :page_size, :page_number
    
    def parse(xml)
      if (response = RTurk::GetReviewableHitsResponse.new(xml)).success?
        response.hits
      end
    end
    
    def to_params
      {
       'PageSize' => (page_size || 100),
       'PageNumber' => (page_number || 1)
       }
    end

  end
  def self.GetReviewableHits(*args, &blk)
    RTurk::GetReviewableHits.create(*args, &blk)
  end

end