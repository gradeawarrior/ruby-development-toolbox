# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: ruby-development-toolbox 1.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-development-toolbox"
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Peter Salas"]
  s.date = "2014-12-17"
  s.description = "A collection of useful utilities and libraries for Ruby development (not Rails)"
  s.email = "psalas+github@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    ".yardopts",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/ruby-development-toolbox.rb",
    "lib/toolbox/array.rb",
    "lib/toolbox/boolean.rb",
    "lib/toolbox/gem_specification.rb",
    "lib/toolbox/hash_diff.rb",
    "lib/toolbox/integer.rb",
    "lib/toolbox/json.rb",
    "lib/toolbox/uuid.rb",
    "ruby-development-toolbox.gemspec",
    "test/helper.rb",
    "test/representations/address.rb",
    "test/representations/person.rb",
    "test/test_toolbox-integer.rb",
    "test/test_toolbox_array.rb",
    "test/test_toolbox_json.rb"
  ]
  s.homepage = "http://github.com/gradeawarrior/ruby-development-toolbox"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Useful Ruby Development Toolbox"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0.8.7.3"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0.8.7.3"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0.8.7.3"])
  end
end

