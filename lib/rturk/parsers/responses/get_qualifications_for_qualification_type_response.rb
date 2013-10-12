# Parses the GetQualificationType Response

module RTurk
  class GetQualificationsForQualificationTypeResponse < Response
    attr_reader :num_results, :total_num_results, :page_number

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//GetQualificationsForQualificationTypeResult'),
        :num_results => 'NumResults',
        :total_num_results => 'TotalNumResults',
        :page_number => 'PageNumber'
      )
    end

    def qualifications
      @qualifications = []
      @xml.xpath('//Qualification').each do |qualification_xml|
        @qualifications << QualificationParser.new(qualification_xml)
      end
      @qualifications
    end
  end
end
