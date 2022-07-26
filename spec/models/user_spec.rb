require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to belong_to(:role) }
  it { is_expected.to have_many(:permissions) }
  it { is_expected.to have_many(:hotels).dependent(:destroy) }
end
