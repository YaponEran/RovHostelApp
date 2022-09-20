require "rails_helper"

RSpec.describe Operations::Buildings::Create, type: :service do
  describe "#call" do
    let!(:hotel) { create(:hotel) }
    let(:params) do
      {
        build_title: "Almaty 1",
        build_postcode: "000400",
        address: "City Almaty, Brodey street build 1",
        phone_number: "+7(002)000-00-11"
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(hotel, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Building)
      end
    end

    context "When params incorrect" do
      it "returns failure" do
        result = subject.call(hotel, {build_title: ""} )
        expect(result).to be_a(Dry::Monads::Failure)
      end
    end 
  end
end