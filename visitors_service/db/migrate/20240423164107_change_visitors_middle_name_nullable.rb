class ChangeVisitorsMiddleNameNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :visitors, :middle_name, true
  end
end
