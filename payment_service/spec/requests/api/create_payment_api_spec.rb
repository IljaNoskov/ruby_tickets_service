require 'rails_helper'
require_relative '../../helpers/payment_helper'
require_relative 'shared_examples_for_payment'

describe GrapeApi::CreatePaymentApi do
  include PaymentHelper

  describe 'POST payment/' do
    let(:url) { '/api/payment' }
    let(:visitor_params) { valid_visitor_params }
    let(:booking_number) { '123' }

    before do
      stub_request(:put,
                   Regexp.new(Settings.update_booking_status_url)).to_return(body: { body: valid_booking }.to_json)
      stub_request(:post, Settings.create_visitor_url).to_return(body: visitor_from(visitor_params).to_json)
      # stub_request(:put, Settings.update_booking_status_url).to_return(body: '')
      stub_request(:delete, Settings.buy_booking_url).to_return(body: '')
    end

    context 'successful creation' do
      after(:all) { Payment.destroy_all }

      it 'returns a 203 status code' do
        post url, params: { booking_number: booking_number, visitor: visitor_params }
        expect(response).to have_http_status(:created)
      end

      it 'returns payment transaction' do
        post url, params: { booking_number: booking_number, visitor: visitor_params }
        result = JSON.parse(response.body)
        expected = to_resonse(Payment.last)

        expect(result).to eq(expected)
      end

      it 'buy booking request was sent' do
        post url, params: { booking_number: booking_number, visitor: visitor_params }

        expect(
          a_request(:delete, Settings.buy_booking_url).with(body: { 'booking_number' => booking_number })
        ).to have_been_made
      end
    end

    context 'expired booking' do
      before do
        stub_request(:any, Regexp.new(Settings.fetch_booking_url)).to_return(body: '{}', status: 404)
      end

      subject { post url, params: { booking_number: booking_number, visitor: visitor_params } and response }
      it_behaves_like 'request failure', :not_acceptable do
        let(:error_message) { I18n.t(:booking_expired) }
      end
    end

    context 'invalid visitor data' do
      before do
        stub_request(:any, Settings.create_visitor_url).to_return(body: '{}', status: 406)
      end

      it 'returns a 406 status code' do
        post url, params: { booking_number: booking_number, visitor: visitor_params }
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    context 'underage visitor' do
      let(:visitor_params) { underage_visitor_params }
      before do
        stub_request(:any, Settings.create_visitor_url).to_return(body: visitor_from(visitor_params).to_json)
      end

      subject { post url, params: { booking_number: booking_number, visitor: visitor_params } and response }
      it_behaves_like 'request failure', :not_acceptable do
        let(:error_message) { I18n.t(:age_restricted, age: Settings.required_age) }
      end

      it 'invalidate booking request was sent' do
        post url, params: { booking_number: booking_number, visitor: visitor_params }

        expect(
          a_request(:put, Settings.update_booking_status_url).with(body: { 'booking_number' => booking_number })
        ).to have_been_made.times(2)
      end
    end

    context 'visitor tries to buy a second ticket' do
      before(:all) { create(:payment) }
      after(:all) { Payment.destroy_all }

      subject { post url, params: { booking_number: booking_number, visitor: visitor_params } and response }
      it_behaves_like 'request failure', :not_acceptable do
        let(:error_message) { I18n.t(:second_ticket) }
      end

      it 'invalidate booking request was sent' do
        post url, params: { booking_number: booking_number, visitor: visitor_params }

        expect(
          a_request(:put, Settings.update_booking_status_url).with(body: { 'booking_number' => booking_number })
        ).to have_been_made.times(2)
      end
    end

    context 'booking service is unavailable' do
      before do
        stub_request(:any, Regexp.new(Settings.fetch_booking_url)).to_timeout
      end

      subject { post url, params: { booking_number: booking_number, visitor: visitor_params } and response }
      it_behaves_like 'request failure', :service_unavailable do
        let(:error_message) { I18n.t(:booking_service_unavailable) }
      end
    end

    context 'visitors service is unavailable' do
      before do
        stub_request(:any, Settings.create_visitor_url).to_timeout
      end

      subject { post url, params: { booking_number: booking_number, visitor: visitor_params } and response }
      it_behaves_like 'request failure', :service_unavailable do
        let(:error_message) { I18n.t(:visitors_service_unavailable) }
      end
    end
  end
end
