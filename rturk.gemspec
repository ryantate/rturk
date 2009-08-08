# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rturk}
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Percival"]
  s.date = %q{2009-07-09}
  s.email = %q{mark@mpercival.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".gitignore",
     "README.markdown",
     "VERSION",
     "examples/blank_slate.rb",
     "examples/external_page.rb",
     "examples/mturk.sample.yml",
     "examples/newtweet.html",
     "examples/review_answer.rb",
     "lib/rturk.rb",
     "lib/rturk/answer.rb",
     "lib/rturk/custom_operations.rb",
     "lib/rturk/external_question_builder.rb",
     "lib/rturk/requester.rb",
     "lib/rturk/utilities.rb",
     "spec/answer_spec.rb",
     "spec/external_question_spec.rb",
     "spec/mturk.sample.yml",
     "spec/requester_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/markpercival/rturk}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Mechanical Turk API Wrapper}
  s.test_files = [
    "spec/answer_spec.rb",
     "spec/external_question_spec.rb",
     "spec/requester_spec.rb",
     "spec/spec_helper.rb",
     "examples/blank_slate.rb",
     "examples/external_page.rb",
     "examples/review_answer.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_dependency('rest-client', '>=0.9')
      s.add_dependency('xml-simple', '>=1.0.12')
    else
      puts "Please update your rubygems to 1.3 or higher"
    end
  else
  end
end
