Spree::Country.class_eval do
  has_many :zip_codes, -> { order('name ASC') }, dependent: :destroy
end
