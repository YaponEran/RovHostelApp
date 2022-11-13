class Individual < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :hotels, dependent: :destroy
  has_many :buildings, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :roles, dependent: :destroy

  before_update :log_info_indi

  def log_info_indi
    logger.info "************* Indi Updated ************** #{email}"
  end

  def individual_admin_user?
    self.users.find_by(admin: true)
  end
end
