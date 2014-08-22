require "spec_helper"
require "i18n_structure/i18n_extension"
require 'active_record'
require 'draper'

I18n.config.load_path += Dir[
  File.join(File.dirname(__FILE__), 'locales', "*.yml").to_s
]

describe I18n do
  describe ".translate_attribute" do
    it "translates attr in model" do
      expect(I18n.translate_attribute(:foo, :bar)).to eq "foobar"
    end

    it "translates with alias without model" do
      expect(I18n.ta(:foo)).to eq "foobar_global"
    end
  end

  describe ".translate_collection" do
    it "translate collection in mode" do
      expect(I18n.translate_collection(:foo, :bar).size).to eq 2
    end

    it "translate collection withoud model (global collection)" do
      expect(I18n.translate_collection(:foo_collection).first).to eq ["element1_key", "element1_value"]
    end
  end

  describe ".translate_label_exist?" do
    it "checks unexisting label" do
      expect(I18n.tl?(:some_dummmy_unexisted_key, :also_dummy_model)).to eq(false)
    end

    it "checks existing label" do
      expect(I18n.translate_label_exist?(:exist_label)).to eq(true)
    end
  end

  describe ".translate_view" do 
    it "translates view" do
      expect(I18n.translate_view(:home, :navigation)).to eq "home page"
    end

    it "translates view using alias" do
      expect(I18n.tv(:home, :navigation)).to eq "home page"
    end

    it "translates view named as partial" do
      expect(I18n.tv(:first_text, :_soma_partial)).to eq "first text"
    end
  end
end