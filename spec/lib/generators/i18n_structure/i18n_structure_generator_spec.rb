require 'spec_helper'
require 'generator_spec'
require 'generators/i18n_structure/i18n_structure_generator'
require 'active_record'
require 'fileutils'

describe I18nStructureGenerator do

  url = File.expand_path("../../tmp", __FILE__)
  destination url
  arguments %w(en)

  before(:all) do
    ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        :database  => "spec/database.sqlite"
    )
    prepare_destination
    FileUtils.mkdir_p("#{url}/config")
    File.new("#{url}/config/application.rb", 'w').close
  end

  describe "when arguments are in expected format" do

    before { run_generator}
    it "creates proper structure" do
      expect(destination_root).to have_structure {
        directory 'config' do
          directory 'locales' do
            directory 'en' do
              directory 'ar'
              file 'labels.yml'
              file 'tooltips.yml'
              file 'collections.yml'
              file 'attributes.yml'
            end
          end
        end
      }
    end
  end

  after do
    FileUtils.rm_rf(url)
  end
end


describe I18nStructureGenerator do

  url = File.expand_path("../../tmp", __FILE__)
  destination url
  arguments %w(someformat)

  before(:all) do
    ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        :database  => "spec/database.sqlite"
    )
    prepare_destination
    FileUtils.mkdir_p("#{url}/config")
    File.new("#{url}/config/application.rb", 'w').close
  end

  describe "when arguments are in the wrong format" do
    it "should exit" do
      expect { run_generator  }.to raise_error SystemExit
    end
  end

  after do
    FileUtils.rm_rf(url)
  end
end

