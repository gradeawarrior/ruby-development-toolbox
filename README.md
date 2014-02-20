# ruby-development-toolbox

A collection of useful utilities and libraries for Ruby development (not Rails)

## Contributing to ruby-development-toolbox
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Development

The project is built by [jeweler](https://github.com/technicalpickles/jeweler). See the project's page for more details about how to manage this gem. However, I will list out quick quidance on a typical release.

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

# Copyright

Copyright (c) 2014 Peter Salas. See LICENSE.txt for
further details.

