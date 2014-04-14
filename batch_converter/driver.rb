#!/usr/bin/env ruby
require './collection_builder'
require 'fileutils'
class Driver
	def unzip(dir)
		Dir.foreach(dir) do |item|
			next if item == '.' or item == '..'
			next if item.split('.').last != 'zip'
			basename = File.basename(item, '.zip')
			# folder_loc = 

			# unzip folder
			`unzip #{File.join(dir, item)} -d #{File.join(dir, basename)}`

			xmlfname = File.join(dir, basename, 'mets.xml')


			if item.split('@').length == 2
				puts "Extracted #{basename}, ready to hydrate item model"
				# should call other code, then clean up the extracted zip file here
				# this should call the BUILD_MODEL code
		  	end
			if item.split('aip').length > 1
				# `unzip #{File.join(dir, item)} -d #{File.join(dir, basename)}`
				# puts "Extracted #{item[0..-5]}, ready to create collection model"
				# should call other code, then clean up the extracted zip file here
				# this should call BUILD_MODEL but  with the flattened collection model
				# puts File.join(dir, basename, basename+'.zip')
				c = CollectionBuilder.build(xmlfname)
				puts c.to_s
			end

			# Clean up directories after
			FileUtils.rm_rf(File.join(dir, basename))
		end
		puts "All items extracted, ready to augment collection with items"
	end
end
Driver.new().unzip('data')
