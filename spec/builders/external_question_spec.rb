require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'cgi'

# Prevent breaking change from Question to ExternalQuestion
describe RTurk::Question do
  it "should alias to ExternalQuestion" do
    RTurk::Question.should == RTurk::ExternalQuestion
  end
end

describe RTurk::ExternalQuestion do

  before(:all) do
  end

  it "should build a question" do
    question = RTurk::ExternalQuestion.new('http://mpercival.com')
    question.url.should == 'http://mpercival.com'
    question.frame_height.should == 400
  end

  it "should build a question " do
    question = RTurk::ExternalQuestion.new('http://mpercival.com', :frame_height => 500, :chapter => 1)
    question.params[:chapter] = 2
    question.url.should == 'http://mpercival.com?chapter=2'
    question.frame_height.should == 500
  end

  it "should build a question " do
    question = RTurk::ExternalQuestion.new('http://mpercival.com?myparam=true&anotherparam=12', :frame_height => 500)
    question.url.should == 'http://mpercival.com?myparam=true&amp;anotherparam=12'
    question.frame_height.should == 500
  end

  it "should build a question with params" do
    params = RTurk::ExternalQuestion.new('http://google.com/', :id => 'foo').to_params
    CGI.unescape(params).should ==
    <<-XML
<ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd">
  <ExternalURL>http://google.com/?id=foo</ExternalURL>
  <FrameHeight>400</FrameHeight>
</ExternalQuestion>
    XML
  end

  it "should build a question without params" do
    params = RTurk::ExternalQuestion.new('http://google.com/').to_params
    CGI.unescape(params).should ==
    <<-XML
<ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd">
  <ExternalURL>http://google.com/</ExternalURL>
  <FrameHeight>400</FrameHeight>
</ExternalQuestion>
    XML
  end



end
