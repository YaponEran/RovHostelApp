class Hotel < ApplicationRecord
  belongs_to :user
  belongs_to :individual
  has_many :buildings, dependent: :destroy

  scope :room_by_hotel, -> (building) { joins(:buildings).where(buildings: {id: building.id } ) }

  scope :with_individual, ->(individual){ where(individual: individual) }
end
