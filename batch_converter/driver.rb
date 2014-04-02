
class Driver
	def unzip
		Dir.foreach('.') do |item|
			next if item == '.' or item == '..'
			if item.split('@').length == 2
				`unzip #{item} -d #{item[0..-5]}`
				puts "Extracted #{item[0..-5]}, ready to hydrate item model"
		  	end
			if item.split('aip').length > 1
				`unzip #{item} -d #{item[0..-5]}`
				puts "Extracted #{item[0..-5]}, ready to create collection model"
			end
		end
		puts "All items extracted, ready to augment collection with items"
	end
end
Driver.new().unzip()
