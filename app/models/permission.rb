class Permission < ApplicationRecord
  AVAILABLE = {
    "employee/users": %i[index show create update destroy],
    "employee/roles": %i[index show create update destroy],
    "employee/hotels": %i[index show create update destroy],
    "employee/buildings": %i[index show create update destroy],
  }

  belongs_to :role

  def self.can?(subject, action)
    exists?(subject: subject, action: action)
  end
end
