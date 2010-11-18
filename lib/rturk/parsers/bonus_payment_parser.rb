module RTurk
  class BonusPaymentParser < RTurk::Parser
    attr_reader :assignment_id, :bonus_amount, :currency_code,
                :reason, :grant_time

    def initialize(payment_xml)
      @xml_obj = payment_xml
      map_content(@xml_obj,
                  :assignment_id => 'AssignmentId',
                  :bonus_amount => 'BonusAmount/Amount',
                  :currency_code => 'BonusAmount/CurrencyCode',
                  :reason => 'Reason',
                  :grant_time => 'GrantTime')
    end
  end
end
