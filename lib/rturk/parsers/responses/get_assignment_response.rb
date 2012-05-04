module RTurk
  class GetAssignmentResponse < Response

    def assignment
      @assignment ||= AssignmentParser.new(@xml.xpath('//Assignment').first)
    end

    def hit
      @hit ||= HITParser.new(@xml.xpath('//HIT').first)
    end
  end
end
