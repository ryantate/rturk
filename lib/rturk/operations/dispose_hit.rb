# http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/ApiReference_DisposeHITOperation.html
module RTurk
  class DisposeHIT < Operation
    
    require_params :hit_id
    attr_accessor :hit_id
    
    def to_params
      {'HITId' => self.hit_id}
    end
    
  end
  
  def self.DisposeHIT(*args, &blk)
    RTurk::DisposeHIT.create(*args, &blk)
  end
  
end