require "rails_helper"

RSpec.describe Operations::Hotels::Create, type: :service do
  let!(:user) { create(:user) }
  let(:params) do
    {
      title: "Almaty hotek",
      adress: "City Almaty, buzurbaeva 20",
      postcode: "000500",
      phone_number: "+7(707)000-00-09",
      user_id: user.id
    }
  end
  describe '#call' do
    context "When all params correct" do
      it "returns success" do
        result = subject.call(user, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Hotel)
      end
    end

    context "Whem params incorrect" do
      it "returns failure" do
        result = subject.call(user, {title: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end