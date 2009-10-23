module RTurk
  class ForceExpireHIT < Operation

    operation 'ForceExpireHIT'
    require_params :hit_id
    attr_accessor :hit_id
    
    def parse(xml)
      RTurk::Response.new(xml)
    end
    
  end
  def self.ForceExpireHIT(*args, &blk)
    RTurk::ForceExpireHIT.create(*args, &blk)
  end
end