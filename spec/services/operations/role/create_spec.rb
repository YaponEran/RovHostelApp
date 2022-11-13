require "rails_helper"

RSpec.describe Operations::Roles::Create, type: :service do
  describe "#call" do
    let!(:individual) { create(:individual) }
    let(:params) do
      {
        title: "Admin",
        role_rank: 0
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(params, individual)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "created new Role" do
        expect{ subject.call(params, individual) }.to change{Role.count}.by(1)
      end
    end

    context "When params is not uniq" do
      let!(:role) { create(:role, title: "Admin") }
      it "returns :uniqueness_violation error" do
        result = subject.call({ title: role.title }, individual)
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end

  end
end