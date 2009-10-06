require 'spec'

SPEC_ROOT = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(SPEC_ROOT)
$LOAD_PATH.unshift(File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib'))

require 'rturk'

@aws = YAML.load(File.open(File.join(SPEC_ROOT, 'mturk.yml')))

Spec::Runner.configure do |config|
  
end