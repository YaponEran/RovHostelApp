require "rails_helper"

RSpec.describe Operations::Roles::Create, type: :service do
  describe "#call" do
    let(:params) do
      {
        title: "Admin"
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "created new Role" do
        expect{ subject.call(params) }.to change{Role.count}.by(1)
      end
    end
  end
end