class AddStateAndCountryToZipCodes < ActiveRecord::Migration
  def change
    change_table :spree_zip_codes do |t|
      t.references :state, index: true
      t.references :country, index: true
    end
  end
end
