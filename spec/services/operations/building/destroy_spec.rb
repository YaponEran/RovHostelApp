require "rails_helper"

RSpec.describe Operations::Buildings::Destroy, type: :service do
  describe "#call" do
    let!(:hotel) { create(:hotel) }
    let!(:building) { create(:building, hotel: hotel) }

    context "With correct params" do
      it "return success" do
        result = subject.call(building)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "deletes hotel building" do
        expect{ subject.call(building) }.to change{Building.count}.by(-1)
      end
    end
  end
end