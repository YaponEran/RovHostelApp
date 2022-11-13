require "rails_helper"

RSpec.describe Operations::Admin::Users::Create, type: :service do
  let!(:individual) { create(:individual) }
  # let!(:role) { create(:role, individual: individual) }
  let(:params) do
    {
      first_name: "Rovshen",
      last_name: "Gulamov",
      mobile_phone: "+7(707)341-59-52",
      password: "1234567",
      email: "eran@mail.ru",
      admin: true,
      # role_id: role.id
    }
  end

  describe "#call" do
    context "whem all params is correct" do
      it "returns success" do
        result = subject.call(individual, params)

        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a User
      end

      it "Create admin user" do
        expect{ subject.call(individual, params) }.to change{ User.count }.by(1)  
      end
    end
  end
end