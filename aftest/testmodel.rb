#for bundle install
require 'bundler/setup'
#necessary if you want to use it as a base for your model
require 'active_fedora'
#yada yada local copy of metadata
require File.join(File.dirname(__FILE__), 'testmodel_metadata.rb')
#now we can bundle install and it'll work!
Bundler.require

class Testmodel < ActiveFedora::Base
  
  # Creating a #descMetadata method that returns the datastream. 
  #
  has_metadata "descMetadata", type: TestmodelMetadata
  
  has_attributes :title, datastream: 'descMetadata', multiple: false
  has_attributes :author, datastream: 'descMetadata', multiple: false
  
  # Uncomment the following lines to add an #attachment method that is a
  #   file_datastream:
  #
  # has_file_datastream "attachment"
  
  # "If you need to add additional attributes to the SOLR document, define the
  # #to_solr method and make sure to use super"
  #
  # def to_solr(solr_document={}, options={})
  #   super(solr_document, options)
  #   solr_document["my_attribute_s"] = my_attribute
  #   return solr_document
  # end

end