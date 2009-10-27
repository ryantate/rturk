# http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/ApiReference_DisposeHITOperation.html
module RTurk
  class DisableHIT < Operation
    
    require_params :hit_id
    attr_accessor :hit_id
    
    def to_params
      {'HITId' => self.hit_id}
    end
    
  end
  
  def self.DisableHIT(*args, &blk)
    RTurk::DisableHIT.create(*args, &blk)
  end
  
end