# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :bearer

  scope :not_deleted, -> { where('deleted_at IS NULL') }
end
