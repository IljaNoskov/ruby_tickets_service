module PaymentHelper
  def valid_visitor_params
    {
      'first_name' => "Евгений",
      'last_name' => "Черкасов",
      'middle_name' => "Олегович",
      'birthdate' => Date.new(2000, 12, 29).to_formatted_s(:db),
      'document_type' => 'passport',
      'document_number' => '1234-123456'
    }
  end

  def valid_booking
    {
      'booking_number' => '123',
      'event_id' => 0,
      'price' => 1000,
      'ticket_type' => 'vip',
      'status' => 'reserved'
    }
  end

  def create_visitor
    {
      'id' => 0,
      'first_name' => "Евгений",
      'last_name' => "Черкасов",
      'middle_name' => "Олегович",
      'birthdate' => Date.new(2000, 12, 29).to_formatted_s(:db),
    }
  end

  def to_resonse(payment)
    {
      'id' => payment.id,
      'booking_number' => payment.booking_number,
      'event_id' => payment.event_id,
      'visitor_id' => payment.visitor_id,
      'price' => payment.price,
      'status' => payment.status
    }
  end

end
