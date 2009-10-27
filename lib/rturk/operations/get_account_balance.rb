module RTurk
  class GetAccountBalance < Operation

    def parse(xml)
       RTurk::GetAccountBalanceResponse.new(xml)
    end
    
  end
  def self.GetAccountBalance
    RTurk::GetAccountBalance.create
  end

end