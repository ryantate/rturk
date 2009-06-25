require '../lib/rturk'
root = File.expand_path(File.dirname(__FILE__))
aws = YAML.load(File.open(File.join(root, 'mturk.yml')))
@turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)

last_hit = File.open(File.join(root, 'last_hit'), 'r').read

p @turk.getAssignmentsForHIT(:HITId => last_hit)
