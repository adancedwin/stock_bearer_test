# frozen_string_literal: true

module Validators
  module Stock
    class Updater < Validators::Base
      params do
        required(:stock_name).filled(:string)
        required(:new_stock_name).filled(:string)
        required(:bearer_name).filled(:string)
      end

      rule(:stock_name) do
        # Might not be a good idea to give away if a record exists
        key.failure('cannot update the record') unless ::Stock.find_by(name: humanize_name(value))
      end

      rule(:new_stock_name) do
        key.failure('is not unique') if ::Stock.find_by(name: humanize_name(value))
      end
    end
  end
end
