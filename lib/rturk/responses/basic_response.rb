module RTurk

  class BasicResponse < Response
    
    def parsed_xml
      @parsed_xml ||= XmlSimple.xml_in(@xml.to_s, {'ForceArray' => false})
    end
    
    def success?
      !parsed_xml['HIT']['Request'].include?('Errors')
    end
    
    def [](key)
      parsed_xml[key]
    end
    
    
  end

end
