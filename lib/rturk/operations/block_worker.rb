# Operation to block a worker
#
# The worker does not see the reason you gave. It's for your records
# only.


module RTurk
  class BlockWorker < Operation

    attr_accessor :worker_id, :reason
    require_params :worker_id, :reason
    
    def to_params
      {'WorkerId' => self.worker_id,
        'Reason' => self.reason}
    end
    
  end
  def self.BlockWorker(*args)
    RTurk::BlockWorker.create(*args)
  end

end