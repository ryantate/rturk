require 'rubygems'
require 'rake'

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb', 'lib/**/*.rb']
  end
rescue LoadError
  puts "YARD is not available. For generating docs, you'll need to sudo gem install yard"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rturk"
    gem.summary = %Q{Mechanical Turk API Wrapper}
    gem.email = "mark@mpercival.com"
    gem.homepage = "http://github.com/markpercival/rturk"
    gem.authors = ["Mark Percival"]
    gem.add_dependency('rest-client', '>= 1.4.0')
    gem.add_dependency('nokogiri', '>= 1.4.1')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rturk-gem #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



