# frozen_string_literal: true

module PaymentHelper
  def valid_visitor_params
    {
      first_name: 'Евгений',
      last_name: 'Черкасов',
      middle_name: 'Олегович',
      birthdate: Date.new(2000, 12, 29).to_formatted_s(:db),
      document_type: 'passport',
      document_number: '1234-123456'
    }
  end

  def underage_visitor_params
    {
      first_name: 'Евгений',
      last_name: 'Черкасов',
      middle_name: 'Олегович',
      birthdate: Date.current.to_formatted_s(:db),
      document_type: 'passport',
      document_number: '1234-123456'
    }
  end

  def visitor_from(visitor_params, _id = 1)
    params = visitor_params.except(:document_number, :document_type)
    params[:id] = 1
    params
  end

  def valid_booking
    {
      booking_number: '123',
      event_id: 1,
      price: 1000,
      ticket_type: 'vip',
      status: 'reserved'
    }
  end

  def to_resonse(payment)
    {
      'id' => payment.id,
      'booking_number' => payment.booking_number,
      'event_id' => payment.event_id,
      'visitor_id' => payment.visitor_id,
      'ticket_id' => payment.ticket_id,
      'price' => payment.price,
      'status' => payment.status
    }
  end
end
