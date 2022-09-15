require "rails_helper"

RSpec.describe Operations::Rooms::Destroy, type: :service do
  describe "#call" do
    let!(:room) { create(:room) }

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