# frozen_string_literal: true

class Bearer < ApplicationRecord
  has_many :stocks, dependent: :destroy
end
