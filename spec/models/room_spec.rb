require 'rails_helper'

RSpec.describe Room, type: :model do
  it { is_expected.to belong_to(:building) }
end
