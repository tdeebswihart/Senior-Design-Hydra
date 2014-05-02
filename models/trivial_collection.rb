# TrivialCollection is well... a trivial Collection model
class TrivialCollection
  attr_accessor :abstract, :note, :identifier, :title, :access_condition
  attr_accessor :items

  def to_s
    str = '<Trivial Collection' + "\n"
    instance_variables.each do |var|
      str += "------------\n#{var}: " + instance_variable_get(var.intern).to_s + "\n"
    end
    str += '/>'
    str
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
