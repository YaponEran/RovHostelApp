class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :role
  has_many :permissions, through: :role
  has_many :hotels, dependent: :destroy

  def is_admin?
    self.admin == true
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def can?(subject, action)
    return  true if admin?

    permissions.can?(subject, action)
  end
end
