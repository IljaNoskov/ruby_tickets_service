require 'rails_helper'

describe GrapeApi::CreateBookingsApi do 
  describe 'post bookings/' do
    let (:url) { 'http://0.0.0.0:3001/api/bookings' }
    let (:event_id) { 1 }
    let (:date) { '2024-04-09' }
    let (:type) { 'ordinary' }
    let (:status) { 'reserved' }
    let (:id) { 1 } 

    before do
      stub_request(:put, ENV['TICKETS_URL']).to_return(status: res_status, body: res_body)
    end 
    context 'return status 201' do
      let (:res_status) { 201 }
      let (:res_body) { { id: id, event_id: event_id, type: type, price: 2000, status: 201 }.to_json }
      it 'return status 201' do
        post url, params: { type: type, date: date, event_id: event_id }
        expect(response).to have_http_status(201)
      end
    end
  end
end