# http://docs.amazonwebservices.com/AWSMturkAPI/2008-08-02/ApiReference_DisposeHITOperation.html
module RTurk
  class SetHITAsReviewing < Operation
    
    require_params :hit_id
    attr_accessor :hit_id, :revert
    
    def to_params
      {'HITId' => self.hit_id, 'Revert' => self.revert}
    end
    
  end
  
  def self.SetHITAsReviewing(*args, &blk)
    RTurk::SetHITAsReviewing.create(*args, &blk)
  end
  
end
