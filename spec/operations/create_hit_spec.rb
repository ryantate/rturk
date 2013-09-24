require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe "using mechanical turk with RTurk" do

  before(:all) do
    aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))
    RTurk.setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
    WebMock.reset!
    faker('create_hit', :operation => "CreateHIT")
    faker('get_hit', :operation => "GetHIT")
  end

  it "should let me build and send a hit" do
    new_hit = RTurk::CreateHIT.new(:title => "Look at some pictures from 4Chan") do |hit|
      hit.max_assignments = 5
      hit.description = 'blah'
      hit.question("http://mpercival.com", :frame_height => 600)
      hit.reward = 0.05
      hit.qualifications.add :approval_rate, {:gt => 80}
    end
    new_hit.max_assignments.should eql(5)
    response = new_hit.request
    response.hit_id.should_not be_nil
  end

  it "should fail if I don't provide required params" do
    lambda do
      hit = RTurk::CreateHIT.new(:title => "Look at some pictures from 4Chan")
      hit.request
    end.should raise_error "Parameters: 'description, reward, question'"  # Rspec is being too clever here
  end

  it "should let me build and send a hit with mostly default values" do
    new_hit = RTurk::CreateHIT.new(:title => "Look at some pictures from 4Chan") do |hit|
      hit.description = 'blah'
      hit.question("http://mpercival.com", :frame_height => 600)
      hit.reward = 0.05
    end
    response = new_hit.request
    response.hit_id.should_not be_nil
  end

  it "should let me create a hit" do
    response = RTurk::CreateHIT(:title => "Look at some pictures from 4Chan") do |hit|
      hit.max_assignments = 5
      hit.description = 'blah'
      hit.question("http://mpercival.com", :test => 'b')
      hit.reward = 0.05
      hit.qualifications.add(:adult, true)
    end
    response.hit.url.should eql('http://workersandbox.mturk.com/mturk/preview?groupId=NYVZTQ1QVKJZXCYZCZVZ')
  end

  it "should not break with old API" do
    # Testing that annotation and note are the same
    new_hit = RTurk::CreateHIT.new(:title => "Look at some pictures from 4Chan") do |hit|
      hit.max_assignments = 5
      hit.description = 'blah'
      hit.question("http://mpercival.com", :frame_height => 600)
      hit.reward = 0.05
      hit.qualifications.add :approval_rate, {:gt => 80}
      hit.note = "My note"
    end
    new_hit.max_assignments.should eql(5)
    new_hit.assignments.should eql(5)
    new_hit.note.should eql("My note")
    new_hit.annotation.should eql("My note")
  end

  it "should let me create a hit with just option arguments" do
    hit = RTurk::CreateHIT.new(:title => "Look at some pictures from 4Chan",
                               :description => "Pics from the b-tards",
                               :max_assignments => 5,
                               :reward => nil,
                               :question => 'http://mpercival.com?picture=1',
                               :qualifications => [
                                 [:approval_rate, {:gt => 80}],
                                 [:adult, true]
                               ]
                               )
    hit.max_assignments.should eql(5)
    hit.qualifications.qualifications.size.should eql(2)
    lambda{hit.request}.should raise_error RTurk::MissingParameters
  end

  it "should rerturn a CreateHITResponse after the request" do
    response = RTurk::CreateHIT(:title => "Look at some pictures from 4Chan") do |hit|
      hit.max_assignments = 5
      hit.description = "foo"
      hit.question("http://mpercival.com", :test => 'b')
      hit.reward = 0.05
      hit.qualifications.add(:adult, true)
    end
    response.is_a?(RTurk::CreateHITResponse).should be_true
    response.hit_id.should == 'GBHZVQX3EHXZ2AYDY2T0'
    response.type_id.should == 'NYVZTQ1QVKJZXCYZCZVZ'
  end

  it "should let me build and send a hit with an internal question" do
    new_hit = RTurk::CreateHIT.new(:title => "Who is your favorite Beatle?") do |hit|
      hit.description = 'blah'
      hit.reward = 0.05
      hit.question_form ExampleQuestionForm.new
    end
    response = new_hit.request
    response.hit_id.should_not be_nil
  end

end
