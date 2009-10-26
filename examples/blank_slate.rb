$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require '../lib/rturk'

aws = YAML.load(File.open(File.join(File.dirname(__FILE__), 'mturk.yml')))
RTurk::setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)

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

