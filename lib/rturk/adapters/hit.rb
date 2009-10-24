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
      
      def find(id)
        
      end
      
      def all_reviewable
        RTurk.GetReviewableHITs.hits
      end

    end

    attr_accessor :id, :type

    def initialize(id, type = nil)
      @id, @type = id, type
    end

    def assignments
      RTurk::GetAssignmentsForHIT(:hit_id => self.id).assignments
    end

    def type_id
      @type_id ||= details.type_id
    end
    
    def details
      @details ||= RTurk::GetHIT(:hit_id => self.id)
    end
    
    def expire!
      RTurk::ForceExpireHIT(:hit_id => self.id)
    end
    
    def dispose!
      RTurk::DisposeHIT(:hit_id => self.id) 
    end


    def url
      if RTurk.sandbox?
        "http://workersandbox.mturk.com/mturk/preview?groupId=#{self.type_id}" # Sandbox Url
      else
        "http://mturk.com/mturk/preview?groupId=#{self.type_id}" # Production Url
      end
    end



  end

end
