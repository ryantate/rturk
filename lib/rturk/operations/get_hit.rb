module RTurk
  class GetHIT < Operation

    require_params :hit_id
    attr_accessor :hit_id
    
    def parse(xml)
      RTurk::GetHITResponse.new(xml)
    end
    
    def to_params
      {"HITId" => self.hit_id}
    end
    
  end
  def self.GetHIT(*args, &blk)
    RTurk::GetHIT.create(*args, &blk)
  end

end