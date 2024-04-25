# frozen_string_literal: true

# Класс, предоставляющий интерфейс для доступа к переменным среды
class Settings
  # Метод получения url для поиска брони
  def self.fetch_booking_url
    ENV['FETCH_BOOKING_URL']
  end

  # Метод получения url для создания пользователя
  def self.create_visitor_url
    ENV['CREATE_VISITOR_URL']
  end

  # Метод получения требуемого для оплаты возраста
  def self.required_age
    ENV['REQUIRED_AGE'].to_i
  end

  # Метод получения url для оповещения брони о удачном завершении покупки
  def self.buy_booking_url
    ENV['BUY_BOOKING_URL']
  end

  # Метод получения url для изменения статуса брони
  def self.update_booking_status_url
    ENV['UPDATE_BOOKING_STATUS_URL']
  end
end
