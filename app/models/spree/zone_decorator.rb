# This is mostly copied from the Spree Zone methods,
# with added support for zipcode zone members
Spree::Zone.class_eval do

  def include?(address)
    return false unless address

    members.any? do |zone_member|
      case zone_member.zoneable_type
      when 'Spree::Country'
        zone_member.zoneable_id == address.country_id
      when 'Spree::State'
        zone_member.zoneable_id == address.state_id
      when 'Spree::ZipCode'
        zone_member.zoneable.name == address.zipcode
      else
        false
      end
    end
  end

  def zip_code_ids
    if kind == 'zip_code'
      members.collect(&:zoneable_id)
    else
      []
    end
  end

  def zip_code_ids=(ids)
    zone_members.destroy_all
    ids.reject{ |id| id.blank? }.map do |id|
      member = Spree::ZoneMember.new
      member.zoneable_type = 'Spree::ZipCode'
      member.zoneable_id = id
      members << member
    end
  end

  def self.match(address)
    return unless matches = self.includes(:zone_members).
      order('zone_members_count', 'created_at').
      select { |zone| zone.include? address }

    ['zip_code', 'state', 'country'].each do |zone_kind|
      if match = matches.detect { |zone| zone_kind == zone.kind }
        return match
      end
    end
    matches.first
  end

  # Indicates whether the specified zone falls entirely within the zone performing
  # the check.
  def contains?(target)
    return false if kind == 'zip_code' && target.kind != 'zip_code'
    return false if kind == 'state' && target.kind == 'country'
    return false if zone_members.empty? || target.zone_members.empty?

    if kind == target.kind
      return false if target.zoneables.any? { |target_zoneable| zoneables.exclude?(target_zoneable) }
    elsif target.kind == 'zip_code'
      if kind == 'state'
        return false if target.zoneables.any? { |target_zip_code| zoneables.exclude?(target_zip_code.state) }
      elsif kind == 'country'
        return false if target.zoneables.any? { |target_zip_code| zoneables.exclude?(target_zip_code.country) }
      end
    elsif target.kind == 'state'
      return false if target.zoneables.any? { |target_state| zoneables.exclude?(target_state.country) }
    end
    true
  end
end # Zone
