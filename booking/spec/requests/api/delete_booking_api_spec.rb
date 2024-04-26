require 'rails_helper'

describe GrapeApi::DeleteBookingsApi do 
  describe 'delete /bookings' do
    let (:url) { 'http://0.0.0.0:3001/api/bookings' }
    let (:ticket_id) { 1 }
    let (:visitor_id) { 1 }
    let (:booking_number) { '123' }
    before do 
      create(:booking)
      stub_request(:put, ENV['TICKETS_URL']).to_return(status: res_status, body: res_body)
    end
    context 'return status 204' do
      let (:res_status) { 201 }
      let (:res_body) { 'deleted' }
      it 'deleted by user request return status 204' do
        delete url, params: { booking_number: booking_number }
        expect(response).to have_http_status(200)
      end
    end
    context 'status 204' do 
      let(:res_status) { 201 }
      let (:res_body) { { id: ticket_id, price: 1000, status: 'buy', event_id: 1, type: 'vip', user_id: visitor_id}.to_json } 
      it 'deleted by buying ticket request return status 204' do
        delete url, params: { booking_number: booking_number, visitor_id: visitor_id }
        expect(response).to have_http_status(200)
      end
    end
  end
end