class Role < ApplicationRecord
  belongs_to :individual
  has_many :users
  has_many :permissions, dependent: :destroy

  scope :with_individual, ->(individual) { where(individual: individual) }

  def find_role_indi(individual)
    self.users.where(individual_id: individual.id)
  end
end
