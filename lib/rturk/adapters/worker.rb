module RTurk
  
  class Worker
    
    def initialize(id)
      @id = id
    end
    
    # Blocks a worker, the reason is required and not shown to the worker
    #
    def block!(reason)
      RTurk::BlockWorker(:worker_id => @id, :reason => reason)
    end
    
    # Unblock the worker
    #
    def unblock!
      RTurk::UnblockWorker(:worker_id => @id)
    end
    
  end
  
end