require "rails_helper"

RSpec.describe Operations::Users::Create, type: :service do
  describe "#call" do
    let!(:role) { create(:role) }
    let(:params) do
      {
        first_name: "Rovshen",
        last_name: "Gulamov",
        mobile_phone: "+7(707)341-59-52",
        password: "1234567",
        email: "eran@mail.ru",
        role_id: role.id
      }
    end
    context "When all params correct" do
      it 'returns Success' do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "creates new User" do
        expect{ subject.call(params) }.to change { User.count}.by(1)
      end
    end

    context "When prams is in correct" do 
      it 'returns failure' do
        result = subject.call({first_name: ""})

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end