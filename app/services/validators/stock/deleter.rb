# frozen_string_literal: true

module Validators
  module Stock
    class Deleter < Validators::Base
      params do
        required(:stock_name).filled(:string)
      end

      rule(:stock_name) do
        # Might not be a good idea to give away if a record exists
        key.failure('cannot delete record') unless ::Stock.find_by(name: humanize_name(value))
      end
    end
  end
end
