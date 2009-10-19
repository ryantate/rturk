module RTurk
  class AnswerParser
    
    # <?xml version="1.0" encoding="UTF-8"?>
    # <QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd\">
    #   <Answer>
    #     <QuestionIdentifier>tweet</QuestionIdentifier>
    #     <FreeText>Spec example</FreeText>
    #   </Answer>
    #   <Answer>
    #     <QuestionIdentifier>Submit</QuestionIdentifier>
    #     <FreeText>Submit</FreeText>
    #   </Answer>
    #   <Answer>
    #     <QuestionIdentifier>Foo</QuestionIdentifier>
    #     <RandomSelector>Bar</RandomSelector>
    #   </Answer>
    # </QuestionFormAnswers>
    
    # <?xml version="1.0" encoding="UTF-8"?>
    # <QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd">
    # <Answer>
    # <QuestionIdentifier>tweet</QuestionIdentifier>\n<FreeText>Spec example</FreeText>\n</Answer>
    # </QuestionFormAnswers>
    
    
    def self.parse(xml)
      answer_xml = Nokogiri::XML(xml)
      responses = []
      response = {}
      answers = answer_xml.xpath('//xmlns:Answer')
      answers.each do |answer|
        key, value = nil, nil
        answer.children.each do |child|
          next if child.blank?
          if child.name == 'QuestionIdentifier'
            key = child.inner_text
          else
            value = child.inner_text
          end
        end
        response[key] = value
      end
      response
    end
    
  end
  
  def self.AnswerParser(xml)
    RTurk::AnswerParser.parse(xml)
  end
end