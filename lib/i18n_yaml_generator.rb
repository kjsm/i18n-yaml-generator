module I18nYamlGenerator
  class Railtie < ::Rails::Railtie
    generators do |app|
      if ::Rails::VERSION::STRING >= '3.2'
        Rails::Generators.configure!(app.config.generators)
      end

      require 'rails/generators/rails/model/model_generator'
      Rails::Generators::ModelGenerator.class_eval do
        class_option :i18n_yaml, :default => 'i18n_yaml'
        hook_for :i18n_yaml
      end

      require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
      Rails::Generators::ScaffoldControllerGenerator.class_eval do
        class_option :i18n_yaml, :default => 'i18n_yaml'
        hook_for :i18n_yaml
      end
    end
  end
end
