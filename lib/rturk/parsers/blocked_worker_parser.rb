module RTurk
  class BlockedWorkerParser < RTurk::Parser
    attr_reader :worker_id, :reason

    def initialize(blocked_worker_xml)
      @xml_obj = blocked_worker_xml
      map_content(@xml_obj,
                  :worker_id => 'WorkerId',
                  :reason => 'Reason')
    end
  end
end
