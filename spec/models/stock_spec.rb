# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock, type: :model do
  context 'valid params' do
    let(:stock) { create(:stock) }

    it { expect { stock }.to change(Stock, :count) }
  end
end
