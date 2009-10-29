module RTurk
  
  class GetAccountBalanceResponse < Response
    
    def amount
      @xml.xpath('//AvailableBalance[1]/Amount').inner_text.to_f
    end
    
  end
  
end