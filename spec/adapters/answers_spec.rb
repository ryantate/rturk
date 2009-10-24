require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::Answers do
  
  before(:all) do
    @answer =  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <QuestionFormAnswers xmlns=\"http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd\">
    <Answer foo='bar'>\n<QuestionIdentifier>tweet</QuestionIdentifier>\n<FreeText>Spec example</FreeText>\n</Answer>
    <Answer>\n<QuestionIdentifier>Submit</QuestionIdentifier>\n<FreeText>Submit</FreeText>\n</Answer>
    <Answer>\n<QuestionIdentifier>Foo</QuestionIdentifier>\n<RandomSelector>Bar</RandomSelector>\n</Answer>
    </QuestionFormAnswers>\n"
    @answer2 = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <QuestionFormAnswers xmlns=\"http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd\">
    <Answer>\n<QuestionIdentifier>tweet</QuestionIdentifier>\n<FreeText>Spec example</FreeText>\n</Answer>
    </QuestionFormAnswers>\n"
    @answer3 = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n    <QuestionFormAnswers xmlns=\"http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd\">\n    <Answer foo='bar'>\n<QuestionIdentifier>tweet</QuestionIdentifier>\n<FreeText>Spec example</FreeText>\n</Answer>\n    <Answer>\n<QuestionIdentifier>Submit</QuestionIdentifier>\n<FreeText>Submit</FreeText>\n</Answer>\n    <Answer>\n<QuestionIdentifier>Foo</QuestionIdentifier>\n<RandomSelector>Bar</RandomSelector>\n</Answer>\n    </QuestionFormAnswers>\n"
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n    <QuestionFormAnswers xmlns=\"http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd\">\n    <Answer>\n<QuestionIdentifier>tweet</QuestionIdentifier>\n<FreeText>Spec example</FreeText>\n</Answer>\n    </QuestionFormAnswers>\n"
  end
  
  it "should parse a answer" do
    RTurk::Answers.new(@answer).to_hash.should == {'Submit' => 'Submit', 'tweet' => 'Spec example', 'Foo' => 'Bar'}
    RTurk::Answers.new(@answer2).to_hash.should == {'tweet' => 'Spec example'}
  end

  
end