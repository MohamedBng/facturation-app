# spec/models/devi_spec.rb
require 'rails_helper'

RSpec.describe Devi, type: :model do
  describe '#payment_methods' do
    let(:devi) { build(:devi) }

    before do
      devi.payment_methods = methods
      if devi.valid?
        devi.save!
      else
        puts "Failed to save Devi: #{devi.errors.full_messages.join(', ')}"
      end
    end

    context 'when setting single payment method' do
      let(:methods) { ['cash'] }

      it 'sets cash as the payment method' do
        expect(devi.payment_method_mask).to eq(Devi.simple_payment_methods[:cash])
        expect(devi.payment_methods).to include('cash')
      end
    end

    context 'when setting multiple payment methods' do
      let(:methods) { ['cash', 'credit_card', 'bank_transfer'] }

      it 'sets multiple payment methods correctly' do
        expected_value = Devi.simple_payment_methods[:cash] |
                         Devi.simple_payment_methods[:credit_card] |
                         Devi.simple_payment_methods[:bank_transfer]
        expect(devi.payment_method_mask).to eq(expected_value)
        expect(devi.payment_methods).to match_array(['cash', 'credit_card', 'bank_transfer'])
      end
    end

    context 'when setting no payment method' do
      let(:methods) { [] }

      it 'has no payment methods' do
        expect(devi.payment_method_mask).to eq(0)
        expect(devi.payment_methods).to be_empty
      end
    end
  end
end
