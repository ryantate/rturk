module RTurk

  # Here's the basic way we'll interact with MTurk for most tasks.
  #
  class Hit
    include RTurk::XmlUtilities

    class << self;

      def create(*args, &blk)
        response = RTurk::CreateHIT(*args, &blk)
        response.hit
      end

    end

    attr_accessor :id, :type

    def initialize(id, type = nil)
      @id, @type = id, type
    end

    def assignments
      GetAssignmentsForHIT(:hit_id => self.id)
    end

    def type
      @type ||= self.populate['type']
    end
    
    # Fetches the HIT details and fills in the attributes accordingly
    # Requires that @id@ be set
    def populate
      
    end


    def url
      if RTurk.sandbox?
        "http://workersandbox.mturk.com/mturk/preview?groupId=#{self.type}" # Sandbox Url
      else
        "http://mturk.com/mturk/preview?groupId=#{self.type}" # Production Url
      end
    end



  end

end
