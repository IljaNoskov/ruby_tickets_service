require 'rails_helper'
require_relative '../../helpers/payment_helper'
require_relative 'shared_examples_for_payment'

describe GrapeApi::PaymentApi do
  include PaymentHelper

  describe 'GET /payment/{id}' do

    before(:all) { create(:payment) }
    after(:all) { Payment.destroy_all }

    let(:payment) { Payment.last }
    let(:url) { "/api/payment/#{payment.id}" }

    context 'successful' do
      it 'returns a 200 status code' do
        get url
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected payment' do
        get url
        result = JSON.parse(response.body)

        expect(result).to eq(to_resonse(payment))
      end
    end

    context 'not found' do
      let(:url) { "/api/payment/999" }

      subject { get url and response }
      it_behaves_like 'request failure', :not_found do
        let(:error_message) { I18n.t(:not_found) }
      end
    end

  end
end
