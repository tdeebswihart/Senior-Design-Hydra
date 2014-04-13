require 'rails/generators'

module ActiveFedora
  class Config::FedoraGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate
      copy_file('fedora.yml', 'config/fedora.yml')
      directory('fedora_conf', 'fedora_conf')
    end
  end
end
