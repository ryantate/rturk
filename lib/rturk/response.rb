require 'nokogiri'

module RTurk
  class Response
    #
    # In some cases we want more than just a hash parsed from the returned
    # XML. This class is our response object, and it can be extended for more
    # functionality.
    #
    
    attr_reader :xml, :raw_xml
    
    def initialize(response)
      @raw_xml = response
      @xml = Nokogiri::XML(@raw_xml)
    end
    
    def success?
      @xml.xpath('//Request/IsValid').inner_text.strip == "True"
      
    end
    
  end
end