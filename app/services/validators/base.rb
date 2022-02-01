# frozen_string_literal: true

module Validators
  class Base < Dry::Validation::Contract
    def humanize_name(name)
      name.split('_').join(' ')
    end
  end
end
