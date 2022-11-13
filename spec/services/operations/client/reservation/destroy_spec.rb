require "rails_helper"

RSpec.describe Operations::Client::Reservations::Destroy, type: :service do
  let!(:reservation) { create(:reservation) }

  describe '#call' do
    context "When all params correcrt" do
      it "returns success" do
        result = subject.call(reservation)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "deletes reservation" do
        expect { subject.call(reservation) }.to change{Reservation.count}.by(-1)
      end
    end
  end
end