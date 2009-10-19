require File.dirname(__FILE__) + '/spec_helper'

describe "using mechanical turk with RTurk" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('create_hit')
  end

  it "should let me build and send a hit" do
    hit = RTurk::CreateHit.new(:title => "Look at some pictures from 4Chan") do |hit|
      hit.assignments = 5
      hit.question("http://mpercival.com", :frame_height => 600)
      hit.reward = 0.05
      hit.qualifications.add :approval_rate, {:gt => 80}
    end
    hit.assignments.should eql(5)
    response = hit.request
    response.success?.should be_true
  end

  it "should let me create a hit" do
    response = RTurk::CreateHit(:title => "Look at some pictures from 4Chan") do |hit|
      hit.assignments = 5
      hit.question("http://mpercival.com", :test => 'b')
      hit.reward = 0.05
      hit.qualifications.add(:adult, true)
    end
    response.success?.should be_true
  end

  it "should let me create a hit with just option arguments" do
    hit = RTurk::CreateHit.new(:title => "Look at some pictures from 4Chan",
                               :assignments => 5,
                               :question => 'http://mpercival.com?picture=1',
                               :qualifications => [
                                 [:approval_rate, {:gt => 80}],
                                 [:adult, true]
                               ]
                               )
    hit.assignments.should eql(5)
    hit.qualifications.qualifications.size.should eql(2)
  end

  it "should rerturn a CreateHitResponse after the request" do
    response = RTurk::CreateHit(:title => "Look at some pictures from 4Chan") do |hit|
      hit.assignments = 5
      hit.question("http://mpercival.com", :test => 'b')
      hit.reward = 0.05
      hit.qualifications.add(:adult, true)
    end
    response.is_a?(RTurk::CreateHitResponse).should be_true
    response.hit_id.should == 'GBHZVQX3EHXZ2AYDY2T0'
    response.hit_type_id.should == 'NYVZTQ1QVKJZXCYZCZVZ'
  end

end
