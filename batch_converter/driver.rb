#!/usr/bin/env ruby
class Driver
	def unzip(dir)
		Dir.foreach(dir) do |item|
			next if item == '.' or item == '..'
			next if item.split('.').last != 'zip'

			if item.split('@').length == 2
				`unzip #{item} -d #{item[0..-5]}`
				puts "Extracted #{item[0..-5]}, ready to hydrate item model"
				# should call other code, then clean up the extracted zip file here
		  	end
			if item.split('aip').length > 1
				`unzip #{item} -d #{item[0..-5]}`
				puts "Extracted #{item[0..-5]}, ready to create collection model"
				# should call other code, then clean up the extracted zip file here
			end
		end
		puts "All items extracted, ready to augment collection with items"
	end
end
Driver.new().unzip('.')
