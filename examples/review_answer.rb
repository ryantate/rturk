require 'rubygems'
require '../lib/rturk'

root = File.expand_path(File.dirname(__FILE__))
aws = YAML.load(File.open(File.join(root, 'mturk.yml')))
RTurk::setup(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)

hits = RTurk.GetReviewableHits

response = RTurk.GetAssignments(:hit_id => '1234567890')

p response
