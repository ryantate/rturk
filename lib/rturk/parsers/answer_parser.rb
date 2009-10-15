module RTurk
  class AnswerParser
    
    def self.parse(xml)
      answer = XmlSimple.xml_in(xml, {'ForceArray' => false})
      response = {}
      answers = answer['Answer']
      answers = Array.new(1) { answers } unless answers.instance_of? Array
      answers.each do |a|
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