module RTurk
  class Assignments < Array
    
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
    
    
    def initialize(assignments)
      
    end
    
  end
  
end