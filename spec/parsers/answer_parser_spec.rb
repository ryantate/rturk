require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::AnswerParser do
  
  before(:all) do
    @answer =  <<-XML
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd"&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;tweet&lt;/QuestionIdentifier&gt;
&lt;FreeText&gt;This is my tweet!&lt;/FreeText&gt;
&lt;/Answer&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;Submit&lt;/QuestionIdentifier&gt;
&lt;FreeText&gt;Submit&lt;/FreeText&gt;
&lt;/Answer&gt;
&lt;/QuestionFormAnswers&gt;
XML
  end
  
  it "should parse a answer" do
    RTurk::AnswerParser.parse(@answer).to_hash.should == {"Submit"=>"Submit", "tweet"=>"This is my tweet!"}
  end

  
end