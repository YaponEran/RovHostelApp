require 'rails_helper'

RSpec.describe Individual, type: :model do
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:buildings) }
  it { is_expected.to have_many(:hotels) }
  it { is_expected.to have_many(:rooms) }
  it { is_expected.to have_many(:roles) }
end
