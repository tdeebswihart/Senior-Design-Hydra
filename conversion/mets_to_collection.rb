#!/usr/bin/env ruby
require 'nokogiri'
require "./trivial_collection"

translation_map = {
	# Prefix:namespace => {suffix => new_name}
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
		# puts "//#{prefix}:#{tag}/text(), #{prefix} => #{namespace}"
		val = doc.xpath("//#{prefix}:#{tag}/text()", "#{prefix}" => "#{namespace}")[0].text
		collection.send("#{attr.intern}=", val)
		# puts "no"
	end
end

puts collection.to_s