# frozen_string_literal: true

require 'rails_helper'
require_relative '../../helpers/visitors_helper'
require_relative '../../shared_examples_for_validation'

describe GrapeApi::ValidateApi do
  include VisitorsHelper

  before(:all) { create(:visitor) }
  after(:all) { Visitor.destroy_all }
  let(:visitor) { Visitor.last }

  describe 'GET /document' do
    let(:url) { '/api/visitors/validate/document' }
    let(:params) { { id: visitor.id, document_type: visitor.document_type, document_number: visitor.document_number } }

    context 'successful validation' do
      subject do
        get url, params: params
        response
      end
      it_behaves_like 'validation result', :ok do
        let(:expected_response) { { 'result' => true, 'visitor' => response_from(visitor) } }
      end
    end

    context 'successfult validation with document autodetection' do
      let(:params) { { id: visitor.id, document_number: visitor.document_number } }

      subject do
        get url, params: params
        response
      end
      it_behaves_like 'validation result', :ok do
        let(:expected_response) { { 'result' => true, 'visitor' => response_from(visitor) } }
      end
    end

    context 'validation failed' do
      let(:params) { { id: visitor.id, document_type: visitor.document_type, document_number: '9999-123456' } }

      subject do
        get url, params: params
        response
      end
      it_behaves_like 'validation result', :ok do
        let(:expected_response) { { 'result' => false, 'visitor' => response_from(visitor) } }
      end
    end

    context 'visitor not found' do
      it 'returns a 404 status code' do
        get url, params: { id: 777, document_type: visitor.document_type, document_number: visitor.document_number }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /age' do
    let(:url) { '/api/visitors/validate/age' }
    let(:params) { { id: visitor.id, age: 13 } }

    context 'successful validation' do
      subject do
        get url, params: params
        response
      end
      it_behaves_like 'validation result', :ok do
        let(:expected_response) { { 'result' => true, 'visitor' => response_from(visitor) } }
      end
    end

    context 'validation failed' do
      let(:params) { { id: visitor.id, age: 26 } }

      subject do
        get url, params: params
        response
      end
      it_behaves_like 'validation result', :ok do
        let(:expected_response) { { 'result' => false, 'visitor' => response_from(visitor) } }
      end
    end

    context 'visitor not found' do
      it 'returns a 404 status code' do
        get url, params: { id: 777, age: 20 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
