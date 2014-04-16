class TrivialCollection
	# doc.xpath('//mods:namePart', 'mods' => 'http://www.loc.gov/mods/v3')
	attr_accessor :abstract, :note, :identifier, :title, :access_condition, :items #,files
	
	def to_s
		str = "<Trivial Collection\n"
		instance_variables.each do |var|
			str += "\t#{var}: " + instance_variable_get(var.intern).to_s
		end
		str += "/>"
		return str
	end

	def add_file(fname)
		self.files ||= []
		self.files.append(GenericFile.new(fname))
	end

	def add_item(it)
		self.items ||= []
		self.items.append(it.value)
	end
end