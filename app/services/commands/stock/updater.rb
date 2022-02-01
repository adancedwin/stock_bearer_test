# frozen_string_literal: true

module Commands
  module Stock
    class Updater < Commands::Base
      def call(params)
        validate_params(params)
        update!(params)
        return_success
      end

      private

      def validate_params(params)
        result = Validators::Stock::Updater.new.call(params)

        return result.to_h if result.success?

        halt(result)
      end

      def update!(params)
        stock = ::Stock.find_by(name: humanize_name(params[:stock_name]))
        stock.update!(
          name: params[:new_stock_name],
          bearer: bearer(params)
        )
      end

      def bearer(params)
        Bearer.create_or_find_by(name: humanize_name(params[:bearer_name]))
      end
    end
  end
end
