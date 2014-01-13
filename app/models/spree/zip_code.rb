module Spree
  class ZipCode < ActiveRecord::Base
    belongs_to :state, class_name: 'Spree::State'
    belongs_to :country, class_name: 'Spree::Country'

    validates :name, presence: true
    validates :country, presence: true

    validate :state_validate

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end

    private
      def state_validate
        return unless country.states_required

        if state.present?
          unless state.country == country
            errors.add(:state, :invalid)
          end
        end

        errors.add :state, :blank if state.blank?
      end
  end
end
