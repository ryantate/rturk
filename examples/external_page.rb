require 'rubygems'
require '../lib/rturk'

root = File.expand_path(File.dirname(__FILE__))
aws = YAML.load(File.open(File.join(root, 'mturk.yml')))
RTurk::setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)

response = RTurk.CreateHit(:title => 'Write a tweet for me') do |hit|
  hit.description = 'Simply write a witty twitter update for my account'
  hit.reward = 0.05
  hit.assignments = 1
  hit.question("http://mpercival.com")
end

p response
