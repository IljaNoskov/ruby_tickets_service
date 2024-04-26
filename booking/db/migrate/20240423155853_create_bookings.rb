class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :ticket_id
      t.string :ticket_type
      t.integer :price
      t.string :status
      t.string :booking_number
      t.integer :event_id

      t.timestamps
    end
  end
end
