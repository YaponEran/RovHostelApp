class Hotel < ApplicationRecord
  belongs_to :user
  has_many :buildings, dependent: :destroy
end
