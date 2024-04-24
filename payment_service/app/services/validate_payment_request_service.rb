class ValidatePaymentRequestService
  def self.call(booking, visitor)
    check_visitor_age(visitor)
    check_existing_payments(visitor, booking)
  end
private

  def self.check_visitor_age(visitor)
    lowest_date = visitor.birthdate.advance(years: Settings.required_age)
    result = Date.current >= lowest_date

    raise NotMeetRequirementsException, I18n.t(:age_restricted, age: Settings.required_age) unless result
  end

  def self.check_existing_payments(visitor, booking)
    payment = Payment.find_by(visitor_id: visitor.id, event_id: booking.event_id, status: 'finished')

    raise NotMeetRequirementsException, I18n.t(:second_ticket) if payment
  end
end
