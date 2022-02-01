# frozen_string_literal: true

module Commands
  module Stock
    class Deleter < Commands::Base
      def call(params)
        validate_params(params)
        delete!(params)
        return_success
      end

      private

      def validate_params(params)
        result = Validators::Stock::Deleter.new.call(params)

        return result.to_h if result.success?

        halt(result)
      end

      def delete!(params)
        stock = ::Stock.find_by(name: humanize_name(params[:stock_name]))
        stock.update!(deleted_at: DateTime.now)
      end
    end
  end
end
