# frozen_string_literal: true

module Presenters
  module Stock
    class IndexPresenter
      def call
        {
          stocks: list_stocks
        }
      end

      def list_stocks
        stocks = ::Stock.includes(:bearer).not_deleted

        stocks.each_with_object([]) do |stock, array|
          array << { stock_name: stock.name, bearer_name: stock.bearer.name }
        end
      end
    end
  end
end
