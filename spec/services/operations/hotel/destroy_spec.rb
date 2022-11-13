require "rails_helper"

RSpec.describe Operations::Hotels::Destroy, type: :service do
  describe "#call" do
    let!(:user) { create(:user) }
    let!(:hotel) { create(:hotel, individual_id: user.individual.id) }

    context "when all params correct" do
      it "returns success" do
        result = subject.call(hotel)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "deletes hotel" do
        expect { subject.call(hotel) }.to change{Hotel.count}.by(-1)
      end
    end
  end
end