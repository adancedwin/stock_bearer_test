# frozen_string_literal: true

class API::V1::Base < Grape::API
  namespace :v1 do
    mount API::V1::StockResource
  end
end
