require 'time'

module RTurk
  class Assignment
    attr_reader :id, :source

    def initialize(id, source = nil)
      @id, @source = id, source
    end

    def bonus_payments
      RTurk::GetBonusPayments(:assignment_id => id).payments
    end

    def approve!(feedback = nil)
      RTurk::ApproveAssignment(:assignment_id => self.id, :feedback => feedback)
    end

    def approve_rejected!(feedback = nil)
      RTurk::ApproveRejectedAssignment(:assignment_id => self.id, :feedback => feedback)
    end

    def reject!(reason)
      RTurk::RejectAssignment(:assignment_id => self.id, :feedback => reason)
    end

    def bonus!(amount, reason)
      RTurk::GrantBonus(:assignment_id => self.id, :worker_id => self.worker_id, :amount => amount, :feedback => reason)
    end

    def worker
      RTurk::Worker.new(self.worker_id)
    end

    def submitted?
      status == 'Submitted'
    end

    def approved?
      status == 'Approved'
    end

    def rejected?
      status == 'Rejected'
    end

    def method_missing(method, *args)
      if self.source.respond_to?(method)
        self.source.send(method, *args)
      else
        super
      end
    end
  end
end
