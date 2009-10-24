module RTurk
  class Answers

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

    attr_accessor :answer_hash

    def initialize(xml)
      answer_xml = Nokogiri::XML(xml)
      @answer_hash = {}
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
        @answer_hash[key] = value
      end
    end
    
    def[](key)
      @answer_hash[key]
    end
    
    def to_hash
      @answer_hash
    end

  end
end
