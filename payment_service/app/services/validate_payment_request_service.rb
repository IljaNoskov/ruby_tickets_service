# frozen_string_literal: true

# Сервис проверки требований оформления платежной транзакции
class ValidatePaymentRequestService
  # метод вызова сервиса
  def self.call(booking, visitor)
    check_visitor_age(visitor)
    check_existing_payments(visitor, booking)
  end

  # проверка возраста посетителя
  def self.check_visitor_age(visitor)
    lowest_date = visitor.birthdate.to_date.advance(years: Settings.required_age)
    result = Date.current.after?(lowest_date)

    Rails.logger.debug "visitor: #{visitor.birthdate}"
    Rails.logger.debug "#{Date.current} >= #{lowest_date}"

    raise NotMeetRequirementsException, I18n.t(:age_restricted, age: Settings.required_age) unless result
  end

  # предотвращение повтороной покупки билета на мероприятие
  def self.check_existing_payments(visitor, booking)
    payment = Payment.find_by(visitor_id: visitor.id, event_id: booking.event_id, status: 'finished')

    raise NotMeetRequirementsException, I18n.t(:second_ticket) if payment
  end
end
