module RTurk
  class ForceExpireHIT < Operation

    require_params :hit_id
    attr_accessor :hit_id
    
    def to_params
      {'HITId' => self.hit_id}
    end
    
  end
  
  def self.ForceExpireHIT(*args, &blk)
    RTurk::ForceExpireHIT.create(*args, &blk)
  end
  
end