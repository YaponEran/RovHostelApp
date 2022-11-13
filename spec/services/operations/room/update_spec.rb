require "rails_helper"

RSpec.describe Operations::Rooms::Update, type: :service do
  describe "#call" do
    let!(:individual) { create(:individual) }
    let!(:hotel) { create(:hotel, individual: individual) }
    let!(:building) { create(:building, hotel: hotel, individual: individual) }
    let!(:room) { create(:room, building: building,  individual: individual) }
    
    let(:params) do
      {
        overnight_kind: "Room2",
        total_room: 1,
        total_bed: 2,
        has_air_con: false,
        has_kitchen: false,
        has_bath: false,
        has_wifi: false,
        bed_number: 12,
        price: 1000.0
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(room, params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "updated room params" do
        result = subject.call(room, params)
        expect(room.overnight_kind).to eq params[:overnight_kind]
        expect(room.total_room).to eq params[:total_room]
      end
    end

    context "Whean params inccorect" do
      it 'returns failure' do
        result = subject.call(room, {overnight_kind: ""} )
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end