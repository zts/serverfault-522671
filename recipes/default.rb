#
# Cookbook Name:: serverfault-522671
# Recipe:: default
#
# Copyright (C) 2013 Zachary Stevens
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

log "testlog" do
  message ">>> testlog resource ran <<<"
  action :nothing
end

# Get the Chef::CookbookVersion for this cookbook
cb = run_context.cookbook_collection[cookbook_name]

# Loop over the array of files
cb.manifest['files'].each do |cbf|
  # cbf['path'] is relative to the cookbook root, eg
  #   'files/default/foo.txt'
  # cbf['name'] strips the first two directories, eg
  #   'foo.txt'
  filename = cbf['name']

  cookbook_file "/tmp/#{filename}" do
    source filename
    notifies :write, "log[testlog]"
  end
end
