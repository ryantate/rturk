require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::RegisterHITType do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    FakeWeb.clean_registry
    faker('register_hit_type', :operation => "RegisterHITType")
  end

  it "should rerturn a CreateHITResponse after the request" do
    response = RTurk::RegisterHITType(:title => "Look at some pictures from 4Chan") do |hit|
      hit.assignments = 5
      hit.description = "foo"
      hit.question("http://mpercival.com", :test => 'b')
      hit.reward = 0.05
      hit.qualifications.add(:adult, true)
    end
    response.is_a?(RTurk::RegisterHITTypeResponse).should be_true
    response.type_id.should == 'KZ3GKTRXBWGYX8WXBW60'
  end

end
