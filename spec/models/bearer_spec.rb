# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bearer, type: :model do
  context 'valid params' do
    let(:bearer) { create(:bearer) }

    it { expect { bearer }.to change(Bearer, :count) }
  end
end
