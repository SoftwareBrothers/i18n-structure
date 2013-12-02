# require 'generators/i18n_translation/lib/yaml'
# require 'generators/i18n_translation/lib/translator'

class I18nStructureGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def main
    unless locale_name =~ /^[a-zA-Z]{2}([-_][a-zA-Z]+)?$/
      log 'ERROR: Wrong locale format. Please give locale in XX or XX-XX format.'
      exit
    end
    log "create i18n structure for locale: #{locale_name}"
    i18n.locale = locale_name

    create_folders_for_locale(locale_name)
    copy_initializer_file(locale)
  end


  private
    def update_locale_lookup_path
      # application "config.asset_host = 'http://example.com'"
      # config.i18n.load_path += Dir[
      #   Rails.root.join('config', 'locales', 'pl' ,'*.{rb,yml}').to_s,
      #   Rails.root.join('config', 'locales', 'pl' , "activerecord" ,'*.{rb,yml}').to_s
      # ]
    end

    def create_folders_for_locale(locale)
      empty_directory "config/locales/#{locale}"
      empty_directory "config/locales/#{locale}/ar"
    end

    def copy_initializer_file(locale)
      empty_directory "config/locales/#{locale}"
      empty_directory "config/locales/#{locale}/ar"
      %w{attributes.yml collections.yml labels.yml tooltips.yml}.each do |fn|
        copy_file fn, "config/locales/#{locale}/#{fn}.rb"
      end
      copy_file "ar.yml" "config/locales/#{locale}/ar"
    end
end