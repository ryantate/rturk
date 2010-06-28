require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::AnswerParser do
  
  before(:all) do
    @answer =  <<-XML
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd"&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;tweet&#91;content&#93;&lt;/QuestionIdentifier&gt;
&lt;FreeText&gt;This is my tweet!&lt;/FreeText&gt;
&lt;/Answer&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;tweet&#91;time&#93;&lt;/QuestionIdentifier&gt;
&lt;FreeText&gt;12345678&lt;/FreeText&gt;
&lt;/Answer&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;Submit&lt;/QuestionIdentifier&gt;
&lt;FreeText&gt;Submit&lt;/FreeText&gt;
&lt;/Answer&gt;
&lt;/QuestionFormAnswers&gt;
XML
  end
  
  it "should parse a answer" do
    RTurk::AnswerParser.parse(@answer).to_hash.should == {"Submit"=>"Submit", "tweet[content]"=>"This is my tweet!", "tweet[time]" => "12345678"}
  end

	it "should parse an answer into a param hash" do
		hash = RTurk::AnswerParser.parse(@answer).to_hash
		RTurk::Parser.new.normalize_nested_params(hash).should == {"Submit"=>"Submit", "tweet"=> {"content" => "This is my tweet!", "time" => "12345678"}}
	end

  
end