require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::Question do
  
  before(:all) do
  end
  
  it "should build a question" do
    question = RTurk::Question.new
    question.url = 'http://mpercival.com'
    question.url_params = {:chapter => 1}
    question.url.should == 'http://mpercival.com?chapter=1' 
    question.frame_height.should == 400
  end

  it "should build a question from an options hash(good for yaml parsing)" do
    question = RTurk::Question.new('http://mpercival.com', :frame_height => 500, :chapter => 1)
    question.url_params = {:chapter => 1}
    question.url.should == 'http://mpercival.com?chapter=1' 
    question.frame_height.should == 500
  end
  
  
  
end