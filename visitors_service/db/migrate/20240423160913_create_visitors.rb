class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name, null: false
      t.string :document_type, null: false
      t.string :document_number, null: false
      t.date :birthdate, null: false

      t.timestamps
    end
  end
end
