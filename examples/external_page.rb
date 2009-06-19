require '../lib/rturk'

props = {:Title=>"Write a twitter update", 
         :MaxAssignments=>1, :LifetimeInSeconds=>3600, 
         :Reward=>{:Amount=>0.05, :CurrencyCode=>"USD"}, 
         :Keywords=>"twitter, blogging, writing, english", 
         :Description=>"Simply write a twitter update for me",
         :RequesterAnnotation=>"Example1",
         :AssignmentDurationInSeconds=>3600, :AutoApprovalDelayInSeconds=>3600, 
         :QualificationRequirement=>[{
           :QualificationTypeId=>"000000000000000000L0", 
           :IntegerValue=>90, 
           :Comparator=>"GreaterThan", 
           :RequiredToPreview=>"false"
           }]
        }
root = File.expand_path(File.dirname(__FILE__))
aws = YAML.load(File.open(File.join(root, 'mturk.yml')))
@turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)
page = RTurk::ExternalQuestionBuilder.build("http://s3.amazonaws.com/mpercival.com/newtweet.html", :id => 'foo')

puts page

p @turk.createHIT(props, page)