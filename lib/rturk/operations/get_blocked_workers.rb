module RTurk
  class GetBlockedWorkers < Operation
    attr_accessor :page_size, :page_number

    def parse(xml)
      GetBlockedWorkersResponse.new(xml)
    end

    def to_params
      {
        'PageSize' => (page_size || 100),
        'PageNumber' => (page_number || 1)
      }
    end
  end

  def self.GetBlockedWorkers(*args, &block)
    RTurk::GetBlockedWorkers.create(*args, &block)
  end
end
