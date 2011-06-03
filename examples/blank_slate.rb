require File.expand_path('../example_helper', __FILE__)

aws = YAML.load(File.open(File.join(File.dirname(__FILE__), 'mturk.yml')))
RTurk::setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'])

hits = RTurk::Hit.all_reviewable

puts "#{hits.size} reviewable hits. \n"

unless hits.empty?
  puts "Approving all assignments and disposing of each hit!"

  hits.each do |hit|
    hit.expire! if (hit.status == "Assignable" || hit.status == 'Unassignable')
    hit.assignments.each do |assignment|
      assignment.approve! if assignment.status == 'Submitted'
    end
    hit.dispose!
  end
end
