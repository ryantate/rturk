# RTurk - A ridiculously simple Mechanical Turk library in Ruby

## What's it do?!?

RTurk is designed to fire off Mechanical Turk tasks for pages that reside on an external site.

The pages could be a part of a rails app, or just a simple javascript enabled form.

If you want to build forms that are hosted on Mechanical Turk, this is not the library you need.
You'd be better off with amazon's official library, in all its XML cruftiness.

## Installation

    gem install rturk
    
## Use

Let's say you have a form at "http://myapp.com/turkers/add_tags" where Turkers can add some tags to items in your catalogue.

### Creating HIT's

    require 'rturk'

    RTurk.setup(YourAWSAccessKeyId, YourAWSAccessKey, :sandbox => true)
    hit = RTurk::Hit.create(:title => "Add some tags to a photo") do |hit|
      hit.assignments = 2
      hit.description = 'blah'
      hit.question("http://myapp.com/turkers/add_tags",
                   :frame_height => 1000)  # pixels for iframe
      hit.reward = 0.05
      hit.qualifications.add :approval_rate, { :gt => 80 }
    end
    
    p hit.url #=>  'https://workersandbox.mturk.com:443/mturk/preview?groupId=Q29J3XZQ1ASZH5YNKZDZ'
    
### Reviewing and Approving hits HIT's

    hits = RTurk::Hit.all_reviewable

    puts "#{hits.size} reviewable hits. \n"

    unless hits.empty?
      puts "Reviewing all assignments"
  
      hits.each do |hit|
        hit.assignments.each do |assignment|
          puts assignment.answers['tags']
          assignment.approve! if assignment.status == 'Submitted'
        end
      end
    end
  
### Wiping all your hits out

    hits = RTurk::Hit.all_reviewable

    puts "#{hits.size} reviewable hits. \n"

    unless hits.empty?
      puts "Approving all assignments and disposing of each hit!"
  
      hits.each do |hit|
        hit.expire!
        hit.assignments.each do |assignment|
          assignment.approve!
        end
        hit.dispose!
      end
    end
    
    
### Logging
Want to see what's going on - enable logging.

    RTurk::logger.level = Logger::DEBUG
    
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

    
    
