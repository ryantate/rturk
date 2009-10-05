describe "The creation of HIT's" do
  
  before(:all) do
    
  end
  
  it "should allow us to create HIT's in a ruby'esque way" do
    @turk = RTurk::Requester.new(AWSAccessKeyId, AWSAccessKey, :sandbox => true)
    @turk.hit do
      hit.assignments = 5
      hit.qualification.approval :gt => 90
      hit.qualification.country :not => 'PH'
      hit.qualification.adult true
      hit.question.url = 'http://mpercival.com'
      hit.question.extra_url_params :chapter => 1 #gives us http://mpercival.com?chapter=1
    end
    
  end
  
end