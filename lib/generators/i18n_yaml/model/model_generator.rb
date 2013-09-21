module I18nYaml
  module Generators #:nodoc:
    class ModelGenerator < Rails::Generators::NamedBase #:nodoc:
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)
      class_option :orm, :required => true
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      SUPPORTED_ORMS = {
        "active_record" => "activerecord",
        "active_model" => "activemodel",
        "mongoid"=> "mongoid"
      }

      attr_reader :locale, :orm_i18n_key

      def model_i18n_yaml_file
        current_orm = options.orm.to_s

        unless SUPPORTED_ORMS.keys.include? current_orm
          say "Not creating translation file - '#{current_orm}' not supported"
          return
        end

        @orm_i18n_key = SUPPORTED_ORMS[current_orm]

        I18n.available_locales.each do |locale|
          @locale = locale
          template "i18n.yml", File.join("config/locales/models/", file_path, "#{locale}.yml")
        end
      end

      protected

      def i18n_scope_key
        i18n_scope.gsub('.', '/')
      end
    end
  end
end
