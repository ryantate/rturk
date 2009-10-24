module RTurk
  class GetAssignmentsForHIT < Operation

    operation 'GetAssignmentsForHIT'
    require_params :hit_id
    
    attr_accessor :hit_id, :page_size, :page_number
    
    def parse(xml)
      GetAssignmentsForHITResponse.new(xml)
    end
    
    def to_params
      {'HITId' => hit_id,
       'PageSize' => (page_size || 100),
       'PageNumber' => page_number}
    end

  end
  def self.GetAssignmentsForHIT(*args, &blk)
    RTurk::GetAssignmentsForHIT.create(*args, &blk)
  end

end
