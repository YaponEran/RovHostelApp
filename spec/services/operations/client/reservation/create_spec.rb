require "rails_helper"

RSpec.describe Operations::Client::Reservations::Create, type: :service do
  let!(:customer_user) { create(:customer_user) }
  let!(:room) { create(:room) }

  let(:params) do
    {
      customer_user_id: customer_user.id,
      room_id: room.id,
      start_at: "01.03.2022",
      end_at: "05.03.2022"
    }
  end
  describe "#call" do
    context "when all params correct" do
      it "returns success" do
        result = subject.call(params)

        # puts "!!!!!!!!!!!!!!"
        # puts customer_user.inspect
        # puts "!!!!!!!!!!!!!!"
      end
    end
  end
end