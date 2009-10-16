require File.dirname(__FILE__) + '/spec_helper'

describe RTurk do
  
  before(:all) do
    @aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
  end
  
  it 'should allow me to set it up with credentials' do
    RTurk.setup(@aws['AWSAccessKeyId'], @aws['AWSAccessKey'], :sandbox => true)
    RTurk.secret_key.should eql @aws['AWSAccessKey']
  end
  
end