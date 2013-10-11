# Parses the GetQualificationType Response

module RTurk
  class GetQualificationScoreResponse < Response
    attr_reader :is_valid

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//QualificationScore'),
        :is_valid => 'IsValid'
      )

      @keywords = @keywords.split(', ') if @keywords
    end
  end
end
