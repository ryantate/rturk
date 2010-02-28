require 'nokogiri'

module RTurk
  class Response < RTurk::Parser
    
    #
    # In some cases we want more than just a hash parsed from the returned
    # XML. This class is our response object, and it can be extended for more
    # functionality.
    #
    
    attr_reader :xml, :raw_xml
    
    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
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
    
    def humanized_errors
      string = self.errors.inject('') { |str, error|
        str + "#{error[:code]}: #{error[:message]}"
      }
      string
    end
    
    def raise_errors
      raise InvalidRequest, self.humanized_errors unless self.success?
    end
    
    def [](element_name)
      self.elements[element_name]
    end
    
    def xpath(*args)
      self.xml.xpath(*args)
    end
    
    def elements
      xml_to_hash(@xml)
    end
    
    def method_missing(method)
      if @attributes && @attributes.include?(method)
        @attributes[method]
      end
    end
    
  end
end