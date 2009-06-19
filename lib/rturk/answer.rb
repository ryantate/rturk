module RTurk
  class Answer
    
    def self.parse(xml)
      answer = XmlSimple.xml_in(xml, {'ForceArray' => false})
      response = {}
      answer['Answer'].each do |a|
        question = a['QuestionIdentifier']
        a.delete('QuestionIdentifier')
        a.each_value do |v|
          response[question] = v
        end
      end
      response
    end
    
  end
end