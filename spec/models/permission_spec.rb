require 'rails_helper'

RSpec.describe Permission, type: :model do
  it { is_expected.to belong_to(:role) }
end
