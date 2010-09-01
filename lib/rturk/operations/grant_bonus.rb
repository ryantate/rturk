module RTurk
  
  # == Grant Bonus operation
  #
  # Grants a worker a bonus
  #
  
  class GrantBonus < Operation

    attr_accessor :assignment_id, :feedback, :worker_id, :amount, :currency
    require_params :assignment_id, :worker_id, :amount, :feedback
    
    def to_params
      {'AssignmentId' => self.assignment_id,
       'BonusAmount.1.Amount' => self.amount,
       'BonusAmount.1.CurrencyCode' => (self.currency || 'USD'),
       'Reason' => self.feedback,
       'WorkerId' => worker_id}
    end
    
  end
  def self.GrantBonus(*args)
    RTurk::GrantBonus.create(*args)
  end

end
