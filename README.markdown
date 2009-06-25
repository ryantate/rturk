# RTurk - A ridiculously simple Mechanical Turk library in Ruby

## What's it do?!?

RTurk is designed to fire off Mechanical Turk tasks for pages that reside on a external site.

The pages could be a part of a rails app, or just a simple javascript enabled form.

If you want to build forms that are hosted on Mechanical Turk, this is not the library you need.
You'd be better off with amazon's official library, in all its XML cruftiness.

## Installation

    sudo gem install markpercival-rturk --sources http://gems.github.com
    
## Use

Let's say you have a form at "http://myapp.com/turkers/add_tags" where Turkers can add some tags to items in your catalogue.

### Creating HIT's

    require 'rturk'

    props = {:Title=>"Add tags to an item", 
             :MaxAssignments=>1, :LifetimeInSeconds=>3600, 
             :Reward=>{:Amount=>0.05, :CurrencyCode=>"USD"}, 
             :Keywords=>"twitter, blogging, writing, english", 
             :Description=>"Simply add some tags for me",
             :RequesterAnnotation=>"Example1",
             :AssignmentDurationInSeconds=>3600, :AutoApprovalDelayInSeconds=>3600, 
             :QualificationRequirement=>[{
               # Approval rate of greater than 90%
               :QualificationTypeId=>"000000000000000000L0", 
               :IntegerValue=>90, 
               :Comparator=>"GreaterThan", 
               :RequiredToPreview=>"false"
               }]
            }

    @turk = RTurk::Requester.new(AWSAccessKeyId, AWSAccessKey, :sandbox => true)
    page = RTurk::ExternalQuestionBuilder.build(
      "http://myapp.com/turkers/add_tags", :item_id => '1234')
    
    # Turkers will be directed to http://myapp.com/turkers/add_tags?item_id=1234&AssignmentId=abcd12345

    p @turk.create_hit(props, page)
    
### Reviewing HIT's

    require 'rturk'
    @turk = RTurk::Requester.new(AWSAccessKeyId, AWSAccessKey, :sandbox => true)

    p @turk.getAssignmentsForHIT(:HITId => 'abcde1234567890')
    
    
    
    