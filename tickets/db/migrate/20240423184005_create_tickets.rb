class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :ticket_type
      t.string :status

      t.timestamps
    end
  end
end
