require 'xmlsimple'

# Creates an object from a Hash
class Hash_To_Obj
  def initialize(hash)
    hash.each do |k,v|
      k = k.tr('^A-Za-z0-9', '')
      self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})  ## create the getter that returns the instance variable
      self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})  ## create the setter that sets the instance variable
    end
  end
end

# Using XmlSimple to convert the XML to a (messy) hash.
# Currently set to read in the mets.xml file in the main AIP zip.
config = XmlSimple.xml_in('mets.xml', { 'KeyAttr' => 'name' })

# Converts the hash to a Ruby object.
obj = Hash_To_Obj.new(config)

# This is a bit "magic numbery"
# I'm not totally sure that this series of calls will always get the right value across all AIP files.
# For the ones we have, it pulls out the names of the datastream zip files.
obj.structMap[0]["div"][0]["div"].each { |x|
  puts x["mptr"][0]["xlink:href"]
}
