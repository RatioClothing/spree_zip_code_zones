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

  spree_version = '~> 2.1.0'
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_core', spree_version
end
