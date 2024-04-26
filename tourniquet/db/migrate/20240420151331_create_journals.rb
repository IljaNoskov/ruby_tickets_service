class CreateJournals < ActiveRecord::Migration[6.1]
  def change
    create_table :journals do |t|
      t.integer :ticket_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :action
      t.string :status
      t.date :date
    end
  end
end
