require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::SearchQualificationTypes do
  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    faker('search_qualification_types', :operation => 'SearchQualificationTypes')
  end

  it "should ensure required params" do
    lambda{RTurk::SearchQualificationTypes()}.should raise_error RTurk::MissingParameters
  end

  it "should successfully request the operation" do
    RTurk::Requester.should_receive(:request).once.with(
      hash_including('Operation' => 'SearchQualificationTypes'))
    RTurk::SearchQualificationTypes({ :must_be_requestable => true }) rescue RTurk::InvalidRequest
  end

  it "should parse and return the result" do
    response = RTurk::SearchQualificationTypes({ :must_be_requestable => true })
    response.num_results.should eql(1)
    qualification_types = response.qualification_types
    qualification_types.size.should eql(1)
    qualification_types.first.qualification_type_id.should eql('WKAZMYZDCYCZP412TZEZ')
    qualification_types.first.name.should eql('WebReviews Qualification Master Test')
    qualification_types.first.keywords.should eql('WebReviews, webreviews, web reviews')
  end
end