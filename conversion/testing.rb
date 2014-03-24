require 'xmlsimple'
require 'pp'

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

config = XmlSimple.xml_in('amets.xml', { 'KeyAttr' => 'name' })

obj = Hash_To_Obj.new(config)

obj.structMap[0]["div"][0]["div"].each { |x|
  puts x["mptr"][0]["xlink:href"]
}
