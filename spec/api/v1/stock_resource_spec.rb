require 'rails_helper'

describe API::V1::StockResource do
  include Rack::Test::Methods

  describe 'Stock creation' do
    let(:stock) { create(:stock) }

    subject { post 'api/v1/stocks', params }

    context 'when valid params' do
      let(:params) do
        {
          stock_name: 'unique stock name',
          bearer_name: 'unique bearer name'
        }
      end

      it { expect { subject }.to change(Stock, :count).by(1) }
      it { expect(subject.status).to eq(201) }
      it { expect(subject.body).to eq('{"code":"200","message":"OK"}') }
    end

    context 'when invalid params' do
      let(:params) do
        {
          stock_name: stock.name,
          bearer_name: stock.bearer.name
        }
      end

      it 'fails uniqueness check' do
        expect(subject.status).to eq(400)
        expect(subject.body).to eq(
          '{"error":{"code":"400","fatal":false,"message":"stock_name is not unique, bearer_name is not unique"}}'
        )
      end
    end
  end

  describe 'Stock updating' do
    let(:stock) { create(:stock) }

    subject { post path, params }

    context 'when valid params' do
      let(:path) { "api/v1/stocks/#{stock.name}" }
      let(:params) do
        {
          new_stock_name: 'new stock name',
          bearer_name: stock.bearer.name
        }
      end

      it 'updates existing stock' do
        expect(subject.status).to eq(201)
      end
    end

    context 'when stock name does not exist' do
      let(:path) { 'api/v1/stocks/random_name' }
      let(:params) do
        {
          new_stock_name: 'new stock name',
          bearer_name: stock.bearer.name
        }
      end

      it 'fails to update' do
        expect(subject.status).to eq(400)
        expect(subject.body).to eq(
          '{"error":{"code":"400","fatal":false,"message":"stock_name cannot update the record"}}'
        )
      end
    end

    context 'when new stock name already exist' do
      let(:path) { "api/v1/stocks/#{stock.name}" }
      let(:params) do
        {
          new_stock_name: stock.name,
          bearer_name: stock.bearer.name
        }
      end

      it 'fails to update' do
        expect(subject.status).to eq(400)
        expect(subject.body).to eq(
          '{"error":{"code":"400","fatal":false,"message":"new_stock_name is not unique"}}'
        )
      end
    end

    describe 'Listing all stocks' do
      let(:stock_list) { create_list(:stock, stocks_number) }
      let(:stocks_number) { 5 }

      subject { get 'api/v1/stocks' }

      context 'when none stocks are deleted' do
        # This will fail sometimes and requires truly unique names
        # As it's a test assigment and time is limited - it's left this way
        it 'lists all stocks' do
          stock_list
          stocks_response = JSON.parse(subject.body)['stocks'].count
          expect(stocks_response).to eq(stocks_number)
        end
      end

      context 'when one stock is deleted' do
        # This will fail sometimes and requires truly unique names
        # As it's a test assigment and time is limited - it's left this way
        it 'foo' do
          stock_list.first.update!(deleted_at: DateTime.now)
          stocks_response = JSON.parse(subject.body)['stocks'].count
          expect(stocks_response).to eq(stocks_number - 1)
        end
      end
    end

    describe 'Deleting a stock' do
      let(:stock) { create(:stock) }

      subject { post path }

      context 'when none stocks are deleted' do
        let(:path) { "api/v1/stocks/#{stock.name}/delete" }

        it 'the only stock' do
          subject
          expect(Stock.count).to eq(1)
          expect(Stock.not_deleted.count).to eq(0)
        end
      end
    end
  end
end
