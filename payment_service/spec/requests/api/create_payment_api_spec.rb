require 'rails_helper'
require_relative '../../helpers/payment_helper'

describe GrapeApi::PaymentApi do
  include PaymentHelper

  describe 'POST payment/' do
    let(:url) { '/api/payment' }
    let(:visitor_params) { valid_visitor_params }
    let(:booking) { valid_booking }
    let(:visitor) { create_visitor }

    before do
      stub_request(:any, Regexp.new(Settings.fetch_booking_url)).to_return(body: booking.to_json)
      stub_request(:any, Settings.create_visitor_url).to_return(body: visitor.to_json)
    end


    context 'successful creation' do
      after(:all) { Payment.destroy_all }

      it 'returns a 203 status code' do
        post url, params: { booking_number: '123', visitor: visitor_params }

        expect(response).to have_http_status(:created)
      end

      it 'returns payment transaction' do
        post url, params: { booking_number: '123', visitor: visitor_params }
        result = JSON.parse(response.body)
        expected = to_resonse(Payment.last)

        expect(result).to eq(expected)
      end
    end

    context 'expired booking' do

    end

    context 'invalid visitor data'
    context 'underage visitor'
    context 'visitor tries to buy a second ticket'
    context 'booking service is unavailable'
    context 'visitors service is unavailable'

  end

end
