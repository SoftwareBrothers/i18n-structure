# I18nStructure

## Put in order your locale files

This gem adds support of nice and nifty structure of locale files to your Rails app.
Gem divides translations into two groups:

- global namespaced translations: they could be repeated among different pages for different resources: for example **send** or **confirm** 
- resource (activerecord) namespaced translations: specific for resource, for example **send request**, **add storey**. They are stored in files named after resource (**article.yml**) inside **config/locales/LOCALE_NAME/ar** folder

**Supported locale structure:** for example polish translations

```yaml
pl:
  labels: #/config/locales/pl/labels.yml
    send: Wyślij
  attributes: #/config/locales/pl/attributes.yml
    name: Nazwa
  collections: #/config/locales/pl/collections.yml
    yes_no: 
      - - Tak
        - true
      - - Nie
        - false
  tooltips: #/config/locales/pl/tooltips.yml
    name: Nazwa jest to .. #Some tooltip for name
  views:
    home_page:
      header: naglowek
  activerecord:
    attributes:
      order: #/config/locales/pl/ar/order.yml
        name: Nazwa zamówienia
        order_type: Rodzaj zamówienia
        order_type_collection: #collections are in attributes namespace
          - - Odrzucone
            - rejected
          - - Zaakceptowane
            - accepted
    tooltips: #/config/locales/pl/ar/order.yml
      order:
        name: Tooltip
    labels: #/config/locales/pl/ar/order.yml
      order:
        create_header: Stwórz zamówienie
```

## ...and use new i18n methods and helpers

I18nStructure gem also adds some usefull methods to I18n module and viwes:

```rails
translate_label(key, model=nil, options={}) #alias tl()
translate_tooltip(key, model=nil, options={}) #alias tt()
translate_attribute(key, model=nil, options={}) #alias ta()
translate_collection(key, model=nil, options={}) #alias tc()
translate_view(key, view_name, options={}) #alias tv()

# labels, tooltips and attributes have corresponding methods which tests presence of given translation:
translate_label?(key, model=nil, options={}) #alias tl?()
...

```

**Usage example for working with :labels**

```ruby
# translate_label(key, model=nil, options={}), alias: tl
tl(:send) # returns Wyślij
tl(:create_order, :order) #returns "Stwórz zamówienie"
tl(:create_order, @order) #works the same
tl(:create_order, Order) #also the same
tl(:create_order, OrderDecorator) #the same again /using Draper gem
```

**and with :collections**
```ruby
# translate_collection(key, model=nil, options={}), alias: tc

# example for global translation:
tc(:yes_no) # returns [["Tak", true],["Nie", false]]

# example for resource translation
tc(:order_type, :order) #returns [["odrzucone", "rejected"], ["zaakceptowane", "accepted"]]
```

**IMPORTANT** - in collections you **don't** have to use ..._collection suffix. Because of this you can iterate through attributes and view selectboxes without extra key operation:

```rails
# haml and simple_form example
[attr1, attr2, attr3].each do |t|
  f.input t, collection: tc(t, :model), :label => ta(t, :model)
end

```

## Installation

Add this line to your application's Gemfile:

    gem 'i18n_structure'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n_structure


## Generator

You can generate all necessary locale files by using generator

    $ rails g i18n_structure pl #for polish translations

Generator also adds:

    $ config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

in your application.rb


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

i18n-structure is Copyright © 2018 SoftwareBrothers.co. It is free software, and may be redistributed under the terms specified in the [LICENSE](LICENSE) file.

## About SoftwareBrothers.co

<img src="https://softwarebrothers.co/assets/images/software-brothers-logo-full.svg" width=240>


We are a software company who provides web and mobile development and UX/UI services, friendly team that helps clients from all over the world to transform their businesses and create astonishing products.

* We are available to [hire](https://softwarebrothers.co/contact).
* If you want to work for us - checkout the [career page](https://softwarebrothers.co/career).
