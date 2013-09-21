module I18nYaml
  module Generators #:nodoc:
    class ScaffoldControllerGenerator < Rails::Generators::NamedBase #:nodoc:
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)

      attr_reader :locale

      def views_i18n_yaml_file
        I18n.available_locales.each do |locale|
          @locale = locale
          template "i18n.yml", File.join("config/locales/views", controller_file_path, "#{locale}.yml")
        end
      end

      protected

      def i18n_namespacing(&block)
        content = capture(&block)
        content = wrap_with_i18n_namespace(content)
        concat(content)
      end

      def wrap_with_i18n_namespace(content)
        scopes = controller_i18n_scope.split('.')

        namespaces = ''
        scopes.each_with_index do |scope, index|
          namespaces += indent("#{scope}:\n", (index + 1) * 2)
        end
        namespaces += indent(content, (scopes.size - 1) * 2)
      end
    end
  end
end
