require "rails_helper"

RSpec.describe Operations::Roles::Update, type: :service do
  describe "#call" do
    let!(:individual) { create(:individual) }
    let(:role) { create(:role, individual: individual) }
    let(:params) do
      {
        title: "Updated role",
        role_rank: 2
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(role, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Role)
        expect(role.title).to eq "Updated role"
      end
    end

    context "When params incorrect" do
      it "returns failue" do
        result = subject.call(role, { title: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end

    context "When title is already take" do
      let!(:another_role) { create(:role, title: "Updated role", individual: individual)}
      it "retunrs :uniqueness_violation error" do
        result = subject.call(role, params)
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:uniqueness_violation)
      end
    end
  end
end