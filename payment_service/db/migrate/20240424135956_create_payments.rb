# frozen_string_literal: true

# Миграция для создания отношения платежной транзакции
class CreatePayments < ActiveRecord::Migration[6.1]
  # Метод вызова миграции
  def change
    create_table :payments do |t|
      t.integer :visitor_id
      t.integer :price
      t.string :status
      t.string :booking_number
      t.integer :event_id

      t.timestamps
    end
  end
end
