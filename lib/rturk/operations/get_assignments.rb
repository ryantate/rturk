module RTurk
  class GetAssignments < Operation

    operation 'GetAssignmentsForHIT'
    require_params :hit_id
    
    attr_accessor :hit_id, :page_size, :page_number
    
    def parse(xml)
      RTurk::GetAssignmentsResponse.new(xml)
    end
    
    def to_params
      {'HITId' => hit_id,
       'PageSize' => (page_size || 100),
       'PageNumber' => page_number}
    end

  end
  def self.GetAssignments(*args, &blk)
    RTurk::GetAssignments.create(*args, &blk)
  end

end
