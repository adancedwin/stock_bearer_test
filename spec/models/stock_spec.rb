require 'rails_helper'

RSpec.describe Stock, type: :model do
  context 'valid params' do
    let(:stock) { create(:stock) }

    it { expect { stock }.to change(Stock, :count) }
  end

  context 'invalid params' do
    let(:stock) { create(:stock) }

    it 'does not have unique name' do
      entity = described_class.create(name: stock.name, bearer_id: stock.bearer_id)

      expect(entity.errors.messages).to eq({:name=>["has already been taken"]})
    end

    it 'does not have bearer_id' do
      entity = described_class.create(name: "unique name")

      expect(entity.errors.messages).to eq({:bearer=>["must exist"]})
    end
  end
end