# frozen_string_literal: true

module Validators
  module Stock
    class Creator < Validators::Base
      params do
        required(:stock_name).filled(:string)
        required(:bearer_name).filled(:string)
      end

      rule(:stock_name) do
        key.failure('is not unique') if ::Stock.find_by(name: humanize_name(value))
      end

      rule(:bearer_name) do
        key.failure('is not unique') if ::Bearer.find_by(name: humanize_name(value))
      end
    end
  end
end
