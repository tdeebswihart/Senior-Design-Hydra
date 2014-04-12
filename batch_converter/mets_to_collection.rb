#!/usr/bin/env ruby
require 'nokogiri'
require "./trivial_collection"

translation_map = {
	# prefix|namespace => {tag => new_name}
	"mods|http://www.loc.gov/mods/v3" => {
		"title" => "title",
		"abstract" => "abstract",
		"identifier" => "identifier",
		"note" => "note",
		"accessCondition" => "access_condition"
	}
}

if ARGV.length < 1
	abort("No metadata XML file specified!")
end

xml_file = File.open(ARGV[0], 'r')
doc = Nokogiri::XML(xml_file)

collection = TrivialCollection.new
translation_map.each_pair do |prefix_with_namespace, tags|
	parts = prefix_with_namespace.split("|")
	prefix = parts[0]
	namespace = parts[1]
	tags.each_pair do |tag, attr|
		val = doc.xpath("//#{prefix}:#{tag}/text()", "#{prefix}" => "#{namespace}")[0].text
		# the following line calls collection.attr = val
		# where attr is the name of an attribute of the collection object
		#
		# the function "intern" turns a string into a symbol: "title".intern -> :title
		# 
		# for example, let attr = "title", and let val = "Title String"
		# with those values this line uses metaprogramming to call:
		#    collection.title = "Title String"
		#
		collection.send("#{attr.intern}=", val)
	end
end

puts collection.to_s