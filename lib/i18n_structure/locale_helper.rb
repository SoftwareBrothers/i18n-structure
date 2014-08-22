module I18nStructure
  module LocaleHelper
    [:labels, :tooltips, :attributes].each do |kind|
      define_method("translate_#{kind.to_s.singularize}") do |*args|
        I18n.send("translate_#{kind.to_s.singularize}", *args)
      end
      alias_method "t#{kind.to_s[0]}", "translate_#{kind.to_s.singularize}"

      define_method("translate_#{kind.to_s.singularize}_exist?") do |*args|
        I18n.send("translate_#{kind.to_s.singularize}_exist?", *args)
      end
      alias_method "t#{kind.to_s[0]}?", "translate_#{kind.to_s.singularize}_exist?"
    end
    [:collections, :views].each do |kind|
      define_method("translate_#{kind.to_s.singularize}") do |*args|
        I18n.send("translate_#{kind.to_s.singularize}", *args)
      end
      alias_method "t#{kind.to_s[0]}", "translate_#{kind.to_s.singularize}"
    end
  end
end