require "rails_helper"

RSpec.describe Operations::Users::Update, type: :service do
  describe "#call" do
    let!(:user) { create(:user) }
    let!(:role) { create(:role) }

    let(:params) do
      {
        first_name: "Bud",
        last_name: "Franchos",
        mobile_phone: "+7(747)241-69-12",
        password: "1234567",
        email: "bud@mail.ru",
        role_id: role.id
      }
    end
    
    context "when all params are correct" do
      it "returns success" do
        result = subject.call(user, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(User)
      end
    end

    context "When params incorrect" do
      it "returns role not found failure" do
        result = subject.call(user, params.merge(role_id: 0))
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:role_not_found)
      end

      it 'returns failure' do
        result = subject.call(params, {first_name: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end