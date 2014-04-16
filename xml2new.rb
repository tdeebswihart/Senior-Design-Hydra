require 'nokogiri'
require 'json'

# assumptions:
# 1) mods and premis will always exist as namespaces in the mets.xml files
# 2) I can use an input format of my own design (JSON)

# notes:
# 1) xpath gets an array, output gets the first element of that array

# bugs:
# premis does not play nice with xpath

modsread = File.read('mods.json') # read the JSON mapping the old names to the new
mods = JSON.parse(modsread)
=begin
premisread = File.read('premis.json')
premis = JSON.parse(premisread)
=end

broken = mods.to_s.split("{") # this block of code breaks the read in JSON into an array of strings
broken = broken[1].split("}") # these strings are used as variable names for indexing the XML later
broken = broken[0].split(",")
brokenlength = broken.length
arrayofmods = Array.new
for i in 0..(brokenlength-1)
	temp = broken[i].split("=>")[0]
	arrayofmods[2*i] = temp.split("\"")[1]
	temp = broken[i].split("=>")[1]
	arrayofmods[(2*i)+1] = temp.split("\"")[1]
end

=begin
broken = premis.to_s.split("{") # the previous block of code has to be repeated for premis now
broken = broken[1].split("}")
broken = broken[0].split(",")
brokenlength = broken.length
arrayofpremis = Array.new
for i in 0..(brokenlength-1)
	temp = broken[i].split("=>")[0]
	arrayofpremis[2*i] = temp.split("\"")[1]
	temp = broken[i].split("=>")[1]
	arrayofpremis[(2*i)+1] = temp.split("\"")[1]
end
=end

halfmodssize = (arrayofmods.length)/2
modsattribute = Array.new
xmlfile = Nokogiri::XML(File.open("mets.xml")) # open the xml file in question using Nokogiri
for i in 0..(halfmodssize-1)
	tempstring = "//mods:#{arrayofmods[2*i]}"
	modsattribute[i] = xmlfile.xpath(tempstring, 'mods' => 'http://www.loc.gov/mods/v3')
end
iterations = modsattribute.length
string2hash = "{"
for i in 0..(iterations-1)
	singleline = modsattribute[i]
	works = singleline.first.content
	string2hash = string2hash + "\"#{arrayofmods[(2*i)+1]}\"" + ":" + "\"#{works.to_s}\""
	if i != (iterations-1) then
		string2hash = string2hash + ",\n"
	end
end
string2hash = string2hash + "}"
File.open('modsnew.json','w') do |f1|
	f1.puts string2hash
end
	
# modshash = {string2hash}
# puts JSON.generate(modshash)

=begin
halfpremissize = (arrayofpremis.length)/2
premisattribute = Array.new
for i in 0..(halfmodssize-1)
	tempstring = "//premis:#{arrayofpremis[2*i]}"
	premisattribute[i] = xmlfile.xpath(tempstring, 'premis' => 'http://www.loc.gov/standards/premis')
end
iterations = premisattribute.length
for i in 0..(iterations-1)
	pline = premisattribute[i]
	pworks = pline.first.content
	puts("#{arrayofpremis[(2*i)+1]}: " + pworks.to_s)
end
=end

# myhash = {:hello => "goodbye"}
# puts JSON.generate(myhash)
