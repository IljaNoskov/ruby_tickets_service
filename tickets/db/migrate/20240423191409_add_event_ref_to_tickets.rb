class AddEventRefToTickets < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :event, null: false, foreign_key: true
  end
end
