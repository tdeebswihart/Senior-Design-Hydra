module CurationConcern
  module Model
    extend ActiveSupport::Concern

    include Sufia::ModelMethods
    include Curate::ActiveModelAdaptor
    include Hydra::Collections::Collectible
    include Solrizer::Common
    include CurationConcern::HumanReadableType

    included do
      has_metadata 'properties', type: Curate::PropertiesDatastream
      has_attributes :relative_path, :depositor, :owner, :representative, datastream: :properties, multiple: false
      class_attribute :human_readable_short_description
    end

    def as_json(options)
      { pid: pid, title: title, model: self.class.to_s, curation_concern_type: human_readable_type }
    end

    def as_rdf_object
      RDF::URI.new(internal_uri)
    end

    def to_solr(solr_doc={}, opts={})
      super(solr_doc, opts)
      index_collection_pids(solr_doc)
      solr_doc[Solrizer.solr_name('noid', Sufia::GenericFile.noid_indexer)] = noid
      solr_doc[Solrizer.solr_name('representative', :stored_searchable)] = self.representative
      add_derived_date_created(solr_doc)
      return solr_doc
    end

    def to_s
      title
    end

    # Returns a string identifying the path associated with the object. ActionPack uses this to find a suitable partial to represent the object.
    def to_partial_path 
      "curation_concern/#{super}"
    end

    def can_be_member_of_collection?(collection)
      collection == self ? false : true
    end

protected

    # A searchable date field that is derived from the (text) field date_created
    def add_derived_date_created(solr_doc)
      if self.respond_to?(:date_created)
        self.class.create_and_insert_terms('date_created_derived', derived_dates, [:dateable], solr_doc)
      end
    end

    def derived_dates
      dates = Array(date_created)
      dates.map { |date| Curate::DateFormatter.parse(date.to_s).to_s }
    end

    def index_collection_pids(solr_doc)
      solr_doc[Solrizer.solr_name(:collection, :facetable)] ||= []
      solr_doc[Solrizer.solr_name(:collection)] ||= []
      self.collection_ids.each do |collection_id|
        collection_obj = ActiveFedora::Base.load_instance_from_solr(collection_id)
        if collection_obj.is_a?(Collection)
          solr_doc[Solrizer.solr_name(:collection, :facetable)] << collection_id
          solr_doc[Solrizer.solr_name(:collection)] << collection_id
        end
      end
      solr_doc
    end

  end
end
