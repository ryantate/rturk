require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::ExternalQuestionBuilder do

  
  it "should build a question with params" do
    RTurk::ExternalQuestionBuilder.build('http://google.com/', :id => 'foo').should == 
    <<-XML
<ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd">
	<ExternalURL>http://google.com/?id=foo</ExternalURL>	
	<FrameHeight>400</FrameHeight>
</ExternalQuestion>
    XML
  end
  
  it "should build a question without params" do
    RTurk::ExternalQuestionBuilder.build('http://google.com/').should == 
    <<-XML
<ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd">
	<ExternalURL>http://google.com/</ExternalURL>	
	<FrameHeight>400</FrameHeight>
</ExternalQuestion>
    XML
  end
  
end