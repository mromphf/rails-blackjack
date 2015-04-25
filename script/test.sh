#!/bin/bash
#
# From Destroy All Software screencast #10, at:
# http://destroyallsoftware.com/screencasts/catalog/fast-tests-with-and-without-rails
#
# Released under the MIT license: http://opensource.org/licenses/MIT
#
# Put this in the script/ directory of your Rails app, then run it with a spec
# filename. If the spec uses spec_helper, it'll be run inside Bundler.
# Otherwise, it'll be run directly with whatever `rspec` executable is on the
# path.

set -e

need_rails=1

if [ $# -gt 0 ]; then # we have args
    filename=$1
    # Remove trailing line numbers from filename, e.g. spec/my_spec.rb:33
    grep_filename=`echo $1 | sed 's/:.*$//g'`

    # if we can't match "spec_helper" in our file we have a stand-alone spec
    grep -r '\bspec_helper\b' $grep_filename > /dev/null || need_rails=''
else # we have no args
    filename='spec'
fi

command='rspec'

if [ $need_rails ]; then
    command="ruby -S bundle exec $command"
fi

RAILS_ENV=test $command $filename

