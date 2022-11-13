class Room < ApplicationRecord
  belongs_to :building
  belongs_to :individual

  scope :with_individual, ->(individual){ where(individual: individual) }
  scope :join_room, -> (individual_id) {joins(:individual).where(individuals: { id: individual_id })}

  OVERNIGHT_KIND = %w[Room Bed]
end
