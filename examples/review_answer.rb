require '../lib/rturk'
root = File.expand_path(File.dirname(__FILE__))
aws = YAML.load(File.open(File.join(root, 'mturk.yml')))
@turk = RTurk::Requester.new(aws['AWSAccessKeyId'], aws['AWSAccessKey'], :sandbox => true)

#GroupID PHAZMBRQNVRTGK0KZZ6Z
#HIT ID CYBGWCWJAXETWZW23X20

p @turk.get_assignments_for_hit('CYBGWCWJAXETWZW23X20')


p @turk.kill_hit('CYBGWCWJAXETWZW23X20')