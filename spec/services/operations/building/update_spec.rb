require "rails_helper"

RSpec.describe Operations::Buildings::Update, tyoe: :service do
  describe "#call" do
    let!(:individual) { create(:individual) }
    let!(:hotel) { create(:hotel, individual: individual) }
    let!(:building) { create(:building, hotel: hotel, individual: individual) }

    let(:params) do
      {
        build_title: "Updated build title",
        build_postcode: "99999",
        address: "Updated build address",
        phone_number: "+7(737)111-22-33"
      }
    end

    context "When all params correct" do
      it "returns success" do
        result = subject.call(building, params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "updates building content" do
        result = subject.call(building, params)
        expect(building.build_title).to eq "Updated build title"
        expect(building.build_postcode).to eq "99999"
        expect(building.address).to eq "Updated build address"
        expect(building.phone_number).to eq "+7(737)111-22-33"
      end
    end

    context "When params incorrect" do
      it "return failure" do
        result = subject.call(building, { build_title: ""} )
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end