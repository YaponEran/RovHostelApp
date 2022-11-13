require "rails_helper"

RSpec.describe Operations::Rooms::Create, type: :service do
  describe "#call" do
    let!(:individual) { create(:individual) }
    let!(:hotel) { create(:hotel, individual: individual) }
    let!(:building) { create(:building, hotel: hotel, individual: individual) }
    let(:params) do
      {
        overnight_kind: "Room",
        total_room: 1,
        total_bed: 2,
        has_air_con: true,
        has_kitchen: true,
        has_bath: true,
        has_wifi: true,
        bed_number: 12,
        price: 0.0
      }
    end

    context "When all params correct" do
      it "returns success" do
        result = subject.call(building, params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "creates new room" do
        result = subject.call(building, params)
        expect(result.value!).to be_a(Room)
      end
    end

    context "Whean params incorrect" do
      it "returns failure" do
        result = subject.call(building, {overnight_kind: "Bed"})
        expect(result).to be_a(Dry::Monads::Failure)
      end

      it "returns :validation_error" do
        result = subject.call(building, {overnight_kind: "Bed"})
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end