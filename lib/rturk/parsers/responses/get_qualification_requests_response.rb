# Parses the GetQualificationRequests Response

module RTurk
  class GetQualificationRequestsResponse < Response
    attr_reader :num_results, :total_num_results, :page_number

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//GetQualificationRequestsResult'),
        :num_results => 'NumResults',
        :total_num_results => 'TotalNumResults',
        :page_number => 'PageNumber'
      )
    end

    def qualification_requests
      @qualification_requests ||= []
      @xml.xpath('//QualificationRequest').each do |qualification_request_xml|
        @qualification_requests << QualificationRequestParser.new(qualification_request_xml)
      end
      @qualification_requests
    end
  end
end