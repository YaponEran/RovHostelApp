require 'rails_helper'

RSpec.describe Building, type: :model do
  it { is_expected.to belong_to(:hotel) }
  it { is_expected.to have_many(:rooms) }
end
