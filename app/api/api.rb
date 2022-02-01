# frozen_string_literal: true

class API < Grape::API
  prefix :api

  default_format :json
  format :json
  content_type :json, 'application/json'

  rescue_from ValidationError do |e|
    error!({ error: { code: '400', fatal: false, message: e.message } }, 400)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!({ error: { code: '404', fatal: false, message: e.message } }, 404)
  end

  rescue_from :all do |e|
    Rails.logger.error e
    error!({ error: { code: '500', fatal: false, message: e.message } }, 500)
  end

  mount API::V1::Base
end
