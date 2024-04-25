# frozen_string_literal: true

# Класс, предоставляющий интерфейс для доступа к переменным среды
class Settings
  def self.fetch_booking_url
    ENV['FETCH_BOOKING_URL']
  end

  def self.create_visitor_url
    ENV['CREATE_VISITOR_URL']
  end

  def self.required_age
    ENV['REQUIRED_AGE'].to_i
  end

  def self.buy_booking_url
    ENV['BUY_BOOKING_URL']
  end

  def self.update_booking_status_url
    ENV['UPDATE_BOOKING_STATUS_URL']
  end
end
