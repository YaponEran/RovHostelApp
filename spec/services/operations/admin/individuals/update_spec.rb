require "rails_helper"

RSpec.describe Operations::Admin::Individuals::Update, type: :service do
  let!(:individual) { create(:individual) }
  let(:params) do
    {
      title: "Ruby nomads hotel",
      judicial_adress: "Almaty street buzurbaeba 25 build 12",
      postal_adress: "Almaty street shevchenko 5 build 1",
      phone: "+7(707)341-59-52",
      email: "rovbro@mail.ru"
    }
  end

  describe "#call" do
    context "when all params correct" do
      it "returns success" do
        result = subject.call(individual, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Individual)
      end

      it "updatest params" do
        result = subject.call(individual, params)
        expect(individual.title).to eq "Ruby nomads hotel"
        expect(individual.judicial_adress).to eq "Almaty street buzurbaeba 25 build 12"
        expect(individual.postal_adress).to eq "Almaty street shevchenko 5 build 1"
        expect(individual.phone).to eq "+7(707)341-59-52"
        expect(individual.email).to eq "rovbro@mail.ru"
      end
    end
  end
end