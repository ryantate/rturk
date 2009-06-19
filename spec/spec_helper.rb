SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT
$LOAD_PATH.unshift(File.join(SPEC_ROOT, '..', 'lib'))
require 'rubygems'
require 'spec'
require 'rturk'