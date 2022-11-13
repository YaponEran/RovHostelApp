require "rails_helper"

RSpec.describe Operations::Hotels::Update, type: :service do
  describe "#call" do
    let!(:user) { create(:user) }
    let!(:hotel) { create(:hotel, user: user, individual_id: user.individual.id)}

    let(:params) do
      {
        title: "City Ashgabad",
        adress: "Andaliba 80",
        postcode: "000500",
        phone_number: "+7(707)341-00-21",
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(hotel, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Hotel)
        expect(hotel.title).to eq "City Ashgabad"
      end
    end

    context "Whem params incorrect" do
      it "returns failure" do
        result = subject.call(hotel, {title: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end