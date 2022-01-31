require 'rails_helper'

RSpec.describe Bearer, type: :model do
  context 'valid params' do
    let(:bearer) { create(:bearer) }

    it { expect { bearer }.to change(Bearer, :count) }
  end

  context 'invalid params' do
    let(:bearer) { create(:bearer) }

    it 'does not have unique name' do
      entity = described_class.create(name: bearer.name)

      expect(entity.errors.messages).to eq({:name=>["has already been taken"]})
    end
  end
end
