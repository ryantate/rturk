require File.dirname(__FILE__) + '/spec_helper'


describe RTurk::Question do
  
  before(:all) do
  end
  
  it "should build a question" do
    question = RTurk::Question.new('http://mpercival.com')
    question.url.should == 'http://mpercival.com' 
    question.frame_height.should == 400
  end

  it "should build a question " do
    question = RTurk::Question.new('http://mpercival.com', :frame_height => 500, :chapter => 1)
    question.params[:chapter] = 2
    question.url.should == 'http://mpercival.com?chapter=2' 
    question.frame_height.should == 500
  end
  
  
  
end