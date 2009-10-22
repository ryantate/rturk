module RTurk

  # Here's the basic way we'll interact with MTurk for most tasks.
  #
  class Hit
    
    attr_accessor :id, :type

    class << self
      # Give is the required parameters and it will request a HIT
      # creation.
      #
      def create(*params, &blk)

      end

      # Get assignments for a hit
      #
      def find(hit_id)

      end

      # Expire a HIT
      #
      def expire(hit_id)

      end

      # Expire all HIT's
      #
      def expire_all

      end

    end
    
    def id
      
    end
    
    

  end

end
