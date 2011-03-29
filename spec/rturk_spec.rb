require 'spec_helper'

describe RTurk do
  
  before(:all) do
    @aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
  end
  
  it 'should allow me to set it up with credentials' do
    RTurk.setup(@aws['AWSAccessKeyId'], @aws['AWSAccessKey'], :sandbox => true)
    RTurk.secret_key.should eql @aws['AWSAccessKey']
  end
  
  
  it "should be able to tell when it's in sandbox" do 
    RTurk.setup(@aws['AWSAccessKeyId'], @aws['AWSAccessKey'], :sandbox => true)
    RTurk.secret_key.should eql @aws['AWSAccessKey']
    RTurk.sandbox?
  end
  
  it "should return its environment as production, the default" do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'])
    RTurk.sandbox?.should be_false
  end
  
end