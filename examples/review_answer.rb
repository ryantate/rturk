require File.expand_path('../example_helper', __FILE__)

aws = YAML.load(File.open(File.join(File.dirname(__FILE__), 'mturk.yml')))
RTurk::setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'])
file = File.open(File.join(File.dirname(__FILE__), 'answers.yml'), 'w')

hits = RTurk::Hit.all_reviewable

puts "#{hits.size} reviewable hits. \n"

unless hits.empty?
  puts "Reviewing all assignments"
  
  hits.each do |hit|
    hit.assignments.each do |assignment|
      file.puts assignment.answers.to_hash.to_yaml
      assignment.approve! if assignment.status == 'Submitted'
    end
  end
end
