require 'time'

module RTurk

  class Assignment

    attr_reader :id, :source

    def initialize(id, source = nil)
      @id, @source = id, source
    end

    def approve!(feedback = nil)
      RTurk::ApproveAssignment(:assignment_id => self.id, :feedback => feedback)
    end

    def reject!(reason)
      RTurk::ApproveAssignment(:assignment_id => self.id, :feedback => reason)
    end

    def bonus!(amount, reason)
      RTurk::GrantBonus(:assignment_id => self.id, :worker_id => self.worker_id, :amount => amount, :feedback => reason)
    end
    
    def method_missing(method, *args)
      if self.source.respond_to?(method)
        self.source.send(method, *args)
      end
    end
  end

end
