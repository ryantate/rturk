module RTurk
  class Response
    #
    # In some cases we want more than just a hash parsed from the returned
    # XML. This class is our response object, and it can be extended for more
    # functionality.
    #
    
    attr_reader :xml
    
    def initialize(response)
      @xml = response
    end
    
    def success?
      @xml.xpath('//Result/IsValid').first.to_s == 'true'
    end
    
  end
end