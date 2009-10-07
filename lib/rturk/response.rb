module RTurk
  class Response
    #
    # Should be able to query a MTurk response for things like success, and HIT ID.
    #
    
    attr_reader :contents

    
    def initialize(response)
      parse(response)
    end
    
    def parse(response)
      @contents = XmlSimple.xml_in(response.to_s, {'ForceArray' => false})
    end
    
    def success?
      # Was the action successfull?
    end
    
    def [](key)
      @contents[key]
    end
    
    
    
  end
end