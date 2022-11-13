require 'rails_helper'

RSpec.describe Hotel, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:individual) }
  it { is_expected.to have_many(:buildings) }
end
