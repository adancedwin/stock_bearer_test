# frozen_string_literal: true

module Commands
  module Stock
    class Creator < Commands::Base
      def call(params)
        validate_params(params)
        create_new!(params)
        return_success
      end

      private

      def validate_params(params)
        result = Validators::Stock::Creator.new.call(params)

        return result.to_h if result.success?

        halt(result)
      end

      def create_new!(params)
        ::Stock.create!(
          name: humanize_name(params[:stock_name]),
          bearer: bearer(params)
        )
      end

      def bearer(params)
        Bearer.create_or_find_by(name: humanize_name(params[:bearer_name]))
      end
    end
  end
end
