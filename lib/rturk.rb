module RTurk
  # Add logging - Should be able to log interaction with Amazon and actions
  
end

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rturk/utilities'
require 'rturk/custom_operations'
require 'rturk/answer'
require 'rturk/external_question_builder'
require 'rturk/requester'
require 'rturk/request'
require 'rturk/qualifications'
require 'rturk/question'
require 'rturk/operations/hit'
