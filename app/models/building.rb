class Building < ApplicationRecord
  belongs_to :hotel
  belongs_to :individual
  has_many :rooms, dependent: :destroy

  scope :with_individual, ->(individual){ where(individual: individual) }
end
