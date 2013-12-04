# require 'generators/i18n_translation/lib/yaml'
require 'rails/generators'
require 'i18n'
require 'yaml'

class I18nStructureGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  argument :locale_name, :type => :string, :default => "pl"

  def main
    unless locale_name =~ /^[a-zA-Z]{2}([-_][a-zA-Z]+)?$/
      log 'ERROR: Wrong locale format. Please give locale in XX or XX-XX format.'
      exit
    end
    log "create i18n structure for locale: #{locale_name}"

    create_folders_for_locale(locale_name)
    copy_initializer_file(locale_name)
    create_ar_locales(locale_name)
    update_locale_lookup_path
  end


  private
    def update_locale_lookup_path
      application "config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]"
    end

    def create_folders_for_locale(locale)
      empty_directory "config/locales/#{locale}"
      empty_directory "config/locales/#{locale}/ar"
    end

    def copy_initializer_file(locale)
      empty_directory "config/locales/#{locale}"
      %w{attributes.yml collections.yml labels.yml tooltips.yml}.each do |fn|
        url = "config/locales/#{locale}/#{fn}"
        copy_file fn, url

        h = YAML::load_file(url)
        h[locale_name] = h.delete("locale_name")
        File.open(url, 'w') {|f| f.write h.to_yaml }
      end
    end

    def create_ar_locales(locale_name)
      table_names = ActiveRecord::Base.connection.tables.reject{|name| name == "schema_migrations"}.collect{|c| c.singularize}
      ar_path = "config/locales/#{locale_name}/ar"
      empty_directory ar_path if table_names.any?
      table_names.each do |table_name|
        file_url = ar_path+"/#{table_name}.yml"
        copy_file "ar.yml", file_url
        h = YAML::load_file(file_url)
        h[locale_name] = h.delete("locale_name")
        h[locale_name]["activerecord"]["errors"]["models"][table_name.singularize] = h[locale_name]["activerecord"]["errors"]["models"].delete("model_name")
        ["labels", "tooltips", "attributes"].each do |r|
          h[locale_name]["activerecord"][r][table_name.singularize] = h[locale_name]["activerecord"][r].delete("model_name")
        end


        File.open(file_url, 'w') {|f| f.write h.to_yaml }
      end
    end
end