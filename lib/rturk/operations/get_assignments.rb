module RTurk
  class GetAssignments < Operation

    operation 'GetAssignmentsForHIT'
    require_params :hit_id
    
    attr_accessor :hit_id, :page_size, :page_number
    
    def parse(xml)
      if (response = RTurk::Response.new(xml)).success?
        assignments = []
        response.xml.xpath('//Assignment').each do |assignment_xml|
          assignments << RTurk::Assignment.new(assignment_xml)
        end
        assignments
      end
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
