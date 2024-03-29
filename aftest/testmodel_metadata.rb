require 'active_fedora'
class TestmodelMetadata < ActiveFedora::OmDatastream

  # Define a terminology for parsing this XML document
  # See: https://github.com/projecthydra/om/wiki/Tame-your-XML-with-OM
  
   set_terminology do |t|
     t.root(path: "fields")
     t.title
     t.author
   end


  # Describe what an empty document looks like
  #
   def self.xml_template
     Nokogiri::XML.parse("<fields/>")
   end
  #


  # "If you need to add additional attributes to the SOLR document, define the
  # #to_solr method and make sure to use super"
  #
  # def to_solr(solr_document={}, options={})
  #   super(solr_document, options)
  #   solr_document["my_attribute_s"] = my_attribute
  #   return solr_document
  # end

end