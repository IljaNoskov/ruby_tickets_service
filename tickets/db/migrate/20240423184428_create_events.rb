class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.integer :ordinary_ticket_count
      t.integer :vip_ticket_count
      t.float :ordinary_ticket_price
      t.float :vip_ticket_price

      t.timestamps
    end
  end
end
