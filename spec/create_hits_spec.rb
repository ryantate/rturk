require File.dirname(__FILE__) + '/spec_helper'

describe "The creation of HIT's" do
  
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    @turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
  end
  
  it "should allow us to create HIT's in a ruby'esque way" do

    hit = Hit.new(:assignments => 5) do |hit|
      hit.qualification.approval :gt => 90
      hit.qualification.country :not => 'PH'
      hit.qualification.adult true
      hit.title = "Look at some dirty pictures from 4Chan"
      hit.question.url = 'http://mpercival.com'
      hit.question.url_params = {:chapter => 1} #gives us http://mpercival.com?chapter=1
    end
    hit.assignments.should eql 5
    @turk.request(hit)
  end
  
end