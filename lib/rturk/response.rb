module RTurk
  class Response
    #
    # Should be able to query a MTurk response for things like success, and HIT ID.
    #

    
    def initialize(response)
      XmlSimple.xml_in(response.to_s, {'ForceArray' => false})
    end
    
    def parse
    end
    
    def success?
      # Was the action successfull?
    end
    
  end
end