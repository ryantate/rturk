module RTurk
  class GetReviewableHITs < Operation

    attr_accessor :page_size, :page_number
    
    def parse(xml)
      RTurk::GetReviewableHITsResponse.new(xml)
    end
    
    def to_params
      {
       'PageSize' => (page_size || 100),
       'PageNumber' => (page_number || 1)
       }
    end

  end
  def self.GetReviewableHITs(*args, &blk)
    RTurk::GetReviewableHITs.create(*args, &blk)
  end

end