require File.dirname(__FILE__) + '/spec_helper'

describe "using mechanical turk with RTurk" do
    
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_hit')
  end
  
  it "should let me create a hit" do
    response = RTurk::CreateHit(:title => "Look at some pictures from 4Chan") do |hit|
      hit.assignments = 5
      hit.question.url = "http://mpercival.com"
      hit.question.params = {:picture_set => 1234}
      hit.reward = 0.05
      # hit.qualifications.approval_rate.greater_than 80
      # hit.qualifications.add(:country => 'PH')
      # hit.qualifications.add(:adult => true)
    end
    response.success?.should  == true
  end
  
  
end