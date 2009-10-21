# RTurk - A ridiculously simple Mechanical Turk library in Ruby

## What's it do?!?

RTurk is designed to fire off Mechanical Turk tasks for pages that reside on a external site.

The pages could be a part of a rails app, or just a simple javascript enabled form.

If you want to build forms that are hosted on Mechanical Turk, this is not the library you need.
You'd be better off with amazon's official library, in all its XML cruftiness.

## Installation

    sudo gem install markpercival-rturk --source http://gemcutter.org
    
## Use

Let's say you have a form at "http://myapp.com/turkers/add_tags" where Turkers can add some tags to items in your catalogue.

### Creating HIT's

    require 'rturk'

    RTurk::Requester.new(YourAWSAccessKeyId, YourAWSAccessKey, :sandbox => true)
    response = RTurk::CreateHit(:title => "Add some tags to a photo") do |hit|
      hit.assignments = 2
      hit.question("http://myapp.com/turkers/add_tags")
      hit.reward = 0.05
      hit.qualifications.approval_rate, {:gt => 80}
    end
    
    response.hit_id #=>  'abcde1234567890'
    
### Reviewing HIT's

    answer = RTurk::GetAssignments(:HITId => 'abcde1234567890')
    answer #=> {'tags' =>  'fail, drunken'} 
    
### Logging
Want to see what's going on - enable logging.

RTurk.log_level(Logger::DEBUG)
    
## Nitty Gritty

Here's a quick peak at what happens on the Mechanical Turk side.

A worker takes a look at your hit. The page will contain an iframe with your question URL loaded inside of it.

Amazon will append the AssignmentID parameter to the URL for your own information. In preview mode this will look like
    http://myapp.com/turkers/add_tags?item_id=1234&AssignmentId=ASSIGNMENT_ID_NOT_AVAILABLE
    
If the Turker accepts the HIT, the page will reload and the iframe URL will resemble

    http://myapp.com/turkers/add_tags?item_id=1234&AssignmentId=1234567890123456789ABC
    
The form in your page MUST CONTAIN the AssignmentID in a hidden input element. You could do this on the server side with a rails app, or on the client side with javascript(check the examples)

Anything submitted in this form will be sent to Amazon and saved for your review later.

## More information

Take a look at the [Amazon MTurk developer docs](http://docs.amazonwebservices.com/AWSMechTurk/latest/AWSMechanicalTurkRequester/) for more information. They have a complete list of API operations, all of which can be called with this library.

    
    