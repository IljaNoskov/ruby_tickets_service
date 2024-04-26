# frozen_string_literal: true

# Модель посетителя, получаемая от внешнего сервиса
class Visitor
  include ActiveModel::Model

  attr_accessor :id, :first_name, :last_name, :middle_name, :birthdate

  # метод определения, хранится ли запись
  def persisted?
    false
  end
end
