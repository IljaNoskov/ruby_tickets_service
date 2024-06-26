# frozen_string_literal: true

require 'rails_helper'
require_relative '../../helpers/visitors_helper'

describe GrapeApi::CreateVisitorApi do
  include VisitorsHelper

  after(:all) { Visitor.destroy_all }

  describe 'POST /' do
    let(:url) { '/api/visitors/' }
    let(:visitor) { build(:visitor) }

    context 'successful creation' do
      it 'returns a 201 status code' do
        post url, params: { visitor: to_request(visitor) }
        expect(response).to have_http_status(:created)
      end

      it 'return expected body' do
        post url, params: { visitor: to_request(visitor) }
        result = JSON.parse(response.body)

        expect(result).to eq(response_from(Visitor.last))
      end
    end

    context 'visitor already exist' do
      before(:all) { create(:visitor) }
      let(:visitor) { Visitor.last }

      it 'returns a 201 status code' do
        post url, params: { visitor: to_request(visitor) }
        expect(response).to have_http_status(:created)
      end

      it 'return expected body' do
        post url, params: { visitor: to_request(visitor) }
        result = JSON.parse(response.body)

        expect(result).to eq(response_from(visitor))
      end
    end

    context 'invalid params' do
      let(:visitor) { build(:visitor, document_number: '132-111') }

      it 'returns a 406 status code' do
        post url, params: { visitor: to_request(visitor) }
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end
end
