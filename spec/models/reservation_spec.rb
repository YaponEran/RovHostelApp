require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { is_expected.to belong_to(:customer_user) }
  it { is_expected.to belong_to(:room) }
end
