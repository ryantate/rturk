# Example response:
# <GetStatisticResult>
#   <Request>
#     <IsValid>True</IsValid>
#   </Request>
#   <DataPoint>
#     <Date>2009-07-13T07:00:00Z</Date>
#     <DoubleValue>20</DoubleValue>
#   </DataPoint>
# </GetStatisticResult>


module RTurk
  class GetRequesterStatisticResponse < Response
    def value
      double_value = @xml.xpath('//DataPoint/DoubleValue').inner_text.strip
      if double_value != ""
        double_value.to_f
      else
        long_value = @xml.xpath('//DataPoint/LongValue').inner_text.strip
        if long_value != ""
          long_value.to_i
        else
          nil
        end
      end
    end
  end
end
