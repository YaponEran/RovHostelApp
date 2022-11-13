require "rails_helper"

RSpec.describe Operations::Client::Reservations::Create, type: :service do
  let!(:customer_user) { create(:customer_user) }

  let!(:individual) { create(:individual) }
  let!(:room) { create(:room) }

  let!(:customer_user_nil) { create(:customer_user, id: nil) }
  let!(:room_nil) { create(:room, id: 0) }


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
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "creates reservation" do
        expect{ subject.call(params) }.to change { Reservation.count }.by(1)
      end
    end

    context "When params incorrect" do
      it "returns :customer_user_not_found" do
        result = subject.call(params.merge(customer_user_id: 0))
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:customer_user_not_found)
      end

      it "returns :room_not_found" do
        result = subject.call(params.merge(room_id: -1))
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:room_not_found)
      end
    end
  end
end