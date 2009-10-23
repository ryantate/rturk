module RTurk
  class GrantBonus < Operation

    operation 'GrantBonus'
    
    def parse(xml)
      RTurk::GrantBonusResponse.new(xml).balance
    end
    
  end
  def self.GrantBonus
    RTurk::GrantBonus.create
  end

end