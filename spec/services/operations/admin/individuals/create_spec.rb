require 'rails_helper'

RSpec.describe Operations::Admin::Individuals::Create, type: :service do
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
    context "When all params correct" do
      it 'returns success' do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it 'creates new individual' do
        expect { subject.call(params) }.to change { Individual.count}.by(1)
      end
    end

    context "when params incorrect" do
      it "returns false" do
        result = subject.call({title: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end

    context "when Individual already exixsts" do
      let!(:individual) { create(:individual, email: "rovbro@mail.ru") }

      it "returns :uniqueness_violation" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq :uniqueness_violation
      end
    end
  end
end