require "rails_helper"

RSpec.describe Operations::Rooms::Destroy, type: :service do
  describe "#call" do
    let!(:individual) { create(:individual) }
    let!(:hotel) { create(:hotel, individual: individual) }
    let!(:building) { create(:building, hotel: hotel, individual: individual) }
    let!(:room) { create(:room, building: building, individual: individual) }

    context "When all params correct" do
      it "returns success" do
        result = subject.call(room)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "Deletes room" do
        expect { subject.call(room) }.to change { Room.count }.by(-1)
      end
    end
  end
end