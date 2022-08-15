class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :permissions, dependent: :destroy
end
