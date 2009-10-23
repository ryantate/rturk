module RTurk

  # Here's the basic way we'll interact with MTurk for most tasks.
  #
  class Hit
    
    attr_accessor :id, :type
    
    def initialize(id, type = nil)
      @id, @type = id, type
    end
    
    def id
      
    end
    
    

  end

end
