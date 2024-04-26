class AddTicketIdToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :ticket_id, :integer
  end
end
