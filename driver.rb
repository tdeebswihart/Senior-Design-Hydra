#!/usr/bin/env ruby
require './model_builder'
require 'fileutils'
require 'json'

class Driver

	def parse_config(filename) 
		@config = JSON.parse(File.read(filename))
		@builder = CollectionBuilder.new
	end

	def unzip(dir)
		Dir.foreach(dir) do |item|
			next if item == '.' or item == '..'
			next if item.split('.').last != 'zip'

			basename = File.basename(item, '.zip')
			# unzip folder. This is shelled out as RubyZip has...issues
			`unzip #{File.join(dir, item)} -d #{File.join(dir, basename)}`

			xmlfname = File.join(dir, basename, 'mets.xml')

			if item.split('@').length == 2
				# DSpace model
				puts "Extracted #{basename}, ready to hydrate item model"
				# should call other code, then clean up the extracted zip file here
				# this should call the BUILD_MODEL code
			elsif item.split('aip').length > 1
				# collection DSpace object
				c = @builder.build(xmlfname, @config)
				puts c.to_s
				# collection here should be SAVED to ActiveFedora, Solr once its hooked up
			end

			# Clean up directories after
			FileUtils.rm_rf(File.join(dir, basename))
		end
		puts "All items extracted, ready to augment collection with items"
	end
end

driver = Driver.new

driver.parse_config('config.json')
driver.unzip('data')
