# frozen_string_literal: true

class API::V1::StockResource < API::V1::Base
  resource :stocks do
    desc 'POST api/v1/stocks' do
      summary 'Creating a Stock with a bearer'
    end
    post '/' do
      Commands::Stock::Creator.new.call(params)
    end

    desc 'POST api/v1/stocks/:stock_name' do
      summary 'Updating a Stock'
    end
    post '/:stock_name' do
      Commands::Stock::Updater.new.call(params)
    end

    desc 'GET api/v1/stocks' do
      summary 'Listing all Stocks with bearer info'
    end
    get '/' do
      Presenters::Stock::IndexPresenter.new.call
    end

    desc 'POST api/v1/stocks/:stock_name/delete' do
      summary 'Deleting a Stock'
    end
    post '/:stock_name/delete' do
      Commands::Stock::Deleter.new.call(params)
    end
  end
end
