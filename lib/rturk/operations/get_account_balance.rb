module RTurk
  class GetAccountBalance < Operation

    operation 'GetAccountBalance'
    
    def parse(xml)
      RTurk::GetAccountBalanceResponse.new(xml).balance
    end
    
  end
  def self.GetAccountBalance
    RTurk::GetAccountBalance.create
  end

end