require "rails_helper"

RSpec.describe Operations::Roles::Destroy, type: :service do
  let!(:role) { create(:role) }
  describe "#call" do
    context "When all params correct" do
      it "returns success" do
        result = subject.call(role)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "deletes role" do
        expect{ subject.call(role) }.to change{Role.count}.by(-1)
      end
    end
  end
end