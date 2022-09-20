class Role < ApplicationRecord
  has_many :users
  has_many :permissions, dependent: :destroy
end
