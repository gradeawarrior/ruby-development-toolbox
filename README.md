# ruby-development-toolbox

A collection of useful utilities and libraries for Ruby development (not Rails)

## Installation

The toolset can be installed via:

	gem install ruby-development-toolbox
	
## Usage

Most modules in the toolbox extend on base Ruby classes to provide additional (or missing) features. For example, the `toolbox/boolean` module provides a `to_bool` operation to:

1. `String`
2. `FalseClass`
3. `TrueClass`
4. and `NilClass`

This is to support operations like the following:

	$ irb
	2.0.0-p353 :001 > require 'toolbox/boolean'
 	 => true
	2.0.0-p353 :002 > "true".to_bool
	 => true 
	2.0.0-p353 :003 > "TRUE".to_bool	
	 => true
	2.0.0-p353 :004 > "False".to_bool
	 => false
	2.0.0-p353 :005 > false.to_bool
	 => false
	2.0.0-p353 :006 > nil.to_bool
	 => nil
	

## Documentation

The projects homepage can be found [here](https://github.com/gradeawarrior/ruby-development-toolbox). You can also refer to the [Rubydoc YARD Server](http://rubydoc.info/github/gradeawarrior/ruby-development-toolbox/frames)

In summary, the following modules are available currently in this gem:

### 1. toolbox/array

This is to implement equivalence check for arrays. In the context of arrays, we use =~ as a means of checking if array1 is contained in array2; or if object is contained in array1
  
### 2. toolbox/boolean

The main application of the Boolean module is to support reading boolean values from a String (e.g. while reading a configuration value) and having the ability to convert it back to a boolean true/false for easier evaluation in your Ruby code

### 3. toolbox/gem_specification

Extends the functionality of a Gem::Specification to be able to retrieve the latest version of gems currently on your system.

### 4. toolbox/hash_diff

Extends the functionality of a Hash to be able to perform (i) diff and (ii) similarity operations. For implementation details, see the Hash class for the extended functions

### 5. toolbox/http

A simple testing client based on the Perl version found in: [QA-Perl-Lib.git](https://github.com/gradeawarrior/QA-Perl-Lib/blob/master/QA/Test/WebService.pm)
  
An example usage would be the following:

       require 'toolbox/http'
  
       response = Toolbox::Http.request(:method => 'GET', :url => 'http://www.google.com')
       if response.code == 200.to_s
         puts "Yay! It worked!"
       else
         puts "Boo! Something broke!" unless response.code == 200.to_s
       end

### 6. toolbox/integer

Extends the functionality of String to support checking if a String can be converted to an Integer

       require 'toolbox/integer'
       
       ['-1', '0', '1', '1.0', 'one', '1 too many'].each do |test|
         puts "This can be converted to an Integer" if test.is_i?
         puts "This cannot be converted to an Integer" unless test.is_i?
       end

### 7. toolbox/json

Extends the functionality of String to support pretty_printing json. This is really a natural extension of the basic String type to support JSON.pretty_generate(string).

### 8. toolbox/uuid

A generic UUID class:

		$ irb
		     require 'toolbox/uuid'
		       => true
		     UUID.generate
		       => "0a391631-22ba-40ea-af2e-65a64de4a42b"
		     UUID.generate
		       => "092516ba-a2f4-45cf-9e1d-c5e63342aaa4"

# Development

The project is built by [jeweler](https://github.com/technicalpickles/jeweler). See the project's page for more details about how to manage this gem. However, I will list out quick guidance on a typical release.

## Active Gem Development

It may be useful to load this project for use in other local projects. The easiest way to configure Ruby is to set `RUBYLIB` environment variable to include all Ruby paths (Separated by colons ':'):

	$ export RUBYLIB=$YOUR_PATH_TO_LIB_DIRECTORY:$OTHER_PATHS

### 1. Version Bump

When you are ready to release, you will need to up-rev the version via the
following methods depending if it's (i) a major, (ii) a minor, or (iii) a patch
release:

    # version:write like before
    $ rake version:write MAJOR=0 MINOR=3 PATCH=0
    
    # bump just major, ie 0.1.0 -> 1.0.0
    $ rake version:bump:major
    
    # bump just minor, ie 0.1.0 -> 0.2.0
    $ rake version:bump:minor
    
    # bump just patch, ie 0.1.0 -> 0.1.1
    $ rake version:bump:patch

### 2. Local Testing of Gem

While doing active work on your project, it is helpful to actively install your gem into your local gem repo using `rake install` on the command-line.

	$ rake install

Do note that discovering what files to include in the gem is written around git. The file must be at least be tracked. You may need to do a `git init` and a `git add .` to at least satisfy the requirements for building a gem from source.

### 3. Releasing

At last, it's time to ship it! Make sure you have everything committed and pushed, then go wild:

	$ rake release

# Contributing to ruby-development-toolbox
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2014 Peter Salas. See LICENSE.txt for
further details.

