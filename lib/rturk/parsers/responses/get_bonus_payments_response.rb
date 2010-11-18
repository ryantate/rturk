module RTurk
  class GetBonusPaymentsResponse < Response
    def payments
      @payments ||= @xml.xpath('//BonusPayment').map do |payment_xml|
        BonusPaymentParser.new(payment_xml)
      end
    end
  end
end
