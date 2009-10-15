module RTurk
  require 'rturk/logging'
  extend RTurk::Logging

  attr_accessor :key, :secret, :host

  def self.setup(key, secret, opts = {})
    
  end
end

$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rturk/utilities'
require 'rturk/macros'
require 'rturk/parsers/answer_parser'
require 'rturk/requester'
require 'rturk/response'
require 'rturk/operation'
require 'rturk/builders/qualifications_builder'
require 'rturk/builders/question_builder'
require 'rturk/operations/create_hit'
require 'rturk/responses/create_hit_response'
