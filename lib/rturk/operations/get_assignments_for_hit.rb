module RTurk
  class GetAssignmentsForHIT < Operation

    require_params :hit_id
    
    attr_accessor :hit_id, :page_size, :page_number, :status
    
    def parse(xml)
      GetAssignmentsForHITResponse.new(xml)
    end
    
    def to_params
      {'HITId' => hit_id,
       'PageSize' => (page_size || 100),
       'PageNumber' => page_number,
       'AssignmentStatus' => status}
    end

  end
  def self.GetAssignmentsForHIT(*args, &blk)
    RTurk::GetAssignmentsForHIT.create(*args, &blk)
  end

end
