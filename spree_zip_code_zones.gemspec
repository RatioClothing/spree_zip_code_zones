# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_zip_code_zones'
  s.version     = '2.0.0'
  s.summary     = 'Enables zipcode zones.'
  s.description = 'Adds zip code functionality equivalent to that of states. Used for the Spree eCommerce framework.'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Anthony Guidarelli'
  s.email             = 'anthony@blinkapplications.com'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_backend'
  s.add_dependency 'spree_core'

end
