module RTurk
  class GetReviewableHITs < Operation
    attr_accessor :page_size, :page_number, :hit_type_id, :status,
                  :sort_property, :sort_direction

    def parse(xml)
      RTurk::GetReviewableHITsResponse.new(xml)
    end

    def to_params
      params = {
       'PageSize' => (page_size || 100),
       'PageNumber' => (page_number || 1)
      }
      params['HITTypeId'] = hit_type_id unless hit_type_id.nil?
      params['Status'] = status unless status.nil?
      params['SortProperty'] = sort_property unless sort_property.nil?
      params['SortDirection'] = sort_direction unless sort_direction.nil?
      params
    end
  end

  def self.GetReviewableHITs(*args, &blk)
    RTurk::GetReviewableHITs.create(*args, &blk)
  end
end