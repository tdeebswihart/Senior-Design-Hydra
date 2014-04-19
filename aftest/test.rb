#needed to run bundle install without rails
require 'bundler/setup'

require File.join(File.dirname(__FILE__), 'testmodel.rb')
#also needed so that bundle install actually works
Bundler.require
#need to initialize your model so that it saves using the configurations in fedora.yml
Testmodel::ActiveFedora.init(:fedora_config_path => File.join(File.dirname(__FILE__), 'fedora.yml'))
#save it with whatever attributes there are
a = Testmodel.new({:namespace=>"changed", :title=>"someone?", :author=>"blank"})
#and saved!
a.save()
#sanity check so that I can view it in curate
puts a.to_s
puts a.pid