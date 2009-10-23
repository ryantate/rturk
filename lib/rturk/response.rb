require 'nokogiri'

module RTurk
  class Response
    include RTurk::XmlUtilities
    
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
    
    def errors
      errors = []
      @xml.xpath('//Errors').each do |error|
        errors << {:code => error.xpath('Error/Code').inner_text,
          :message => error.xpath('Error/Message').inner_text}
      end
      errors
    end
    
    def [](element_name)
      self.elements[element_name]
    end
    
    def elements
      xml_to_hash(@xml)
    end
    
  end
end