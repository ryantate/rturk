# Parses the GetBlockedWorkers Response

module RTurk
  class GetBlockedWorkersResponse < Response
    attr_reader :num_results, :total_num_results, :page_number

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//GetBlockedWorkersResult'),
        :num_results => 'NumResults',
        :total_num_results => 'TotalNumResults',
        :page_number => 'PageNumber'
      )
    end

    def workers
      @blocked_workers ||= []
      @xml.xpath('//WorkerBlock').each do |blocked_worker_xml|
        @blocked_workers << BlockedWorkerParser.new(blocked_worker_xml)
      end
      @blocked_workers
    end
  end
end
