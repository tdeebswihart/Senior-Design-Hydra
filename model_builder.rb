#!/usr/bin/env ruby
require 'nokogiri'
require "./models/trivial_collection"
# require "./models/trivial_model"

# This class is meant to build a ActiveFedora Model
# from an XML file of an AIP export.
class ModelBuilder

	# The base method of ModelBuilder
	# It creates a nex colection from a supplied mapping and XML tile.
	# Params:
	# +xmlfname+:: The path to the XML file to read from.
	# +translation_map+:: A JSON formatted mapping, as defined in the manual.
	def build(xmlfname, translation_map)
		xml_file = File.open(xmlfname, 'r')
		doc = Nokogiri::XML(xml_file)

		collection = TrivialCollection.new
		translation_map.each_pair do |prefix_with_namespace, tags|
			parts = prefix_with_namespace.split("|")
			prefix = parts[0]
			namespace = parts[1]

			tags.each_pair do |tag, attr|
				search_path = ".//#{prefix}:#{tag}"
				if parts.length > 2
					search_path += parts[2]
				end
				val = doc.xpath(search_path, "#{prefix}" => "#{namespace}")[0].text
				# the following line calls collection.attr = val
				# where attr is the name of an attribute of the collection object
				#
				# the function "intern" turns a string into a symbol: "title".intern -> :title
				# 
				# for example, let attr = "title", and let val = "Title String"
				# with those values this line uses metaprogramming to call:
				#    collection.title = "Title String"
				#
				if attr[attr.length-1] == 's'
					# dealing with an attribute we can have multiple of
					attr_nonplural = attr[0..-2] # strip the s
					puts val
					collection.send("add_#{attr.intern}", val.value)
				else
					# val = val[0].text
					collection.send("#{attr.intern}=", val)
				end
			end
		end

		return collection
	end
end
