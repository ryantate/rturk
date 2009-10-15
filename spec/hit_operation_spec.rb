require File.dirname(__FILE__) + '/spec_helper'

describe "The creation of a HIT operation" do
  
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    @turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end
  
  it "should allow us to create HIT's in a ruby'esque way" do

    hit = RTurk::Hit.new(:assignments => 5) do |hit|
      hit.qualification.approval :gt => 90
      hit.qualification.country :not => 'PH'
      hit.qualification.adult true
      hit.title = "Look at some dirty pictures from 4Chan"
      hit.question('http://mpercival.com', :chapter => 1)
      hit.question.params[:chapter] = 2 #change the parameters
    end
    
    hit.assignments.should eql 5
    hit.title.should eql "Look at some dirty pictures from 4Chan"
    hit.question.url.should == "http://mpercival.com?chapter=2"
  end
  
  it "should allow us to create HIT's with a hash from yaml" do

    hit = RTurk::Hit.new(:assignments => 5, :title => "Look at some dirty pictures from 4Chan",
                         :question => 'http://mpercival.com', :assignments => 5,
                         :qualification => 
                            {
                              :approval => {:gt => 90},
                              :adult => true,
                              :country => {:not => 'PH'}
                            },
                          :description => "Get paid in nickels!")
    hit.assignments.should eql 5
    hit.title.should eql "Look at some dirty pictures from 4Chan"
  end
  
end