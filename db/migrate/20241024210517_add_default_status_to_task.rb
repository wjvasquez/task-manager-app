class AddDefaultStatusToTask < ActiveRecord::Migration[7.2]
  def change
    change_column_default :tasks, :status, "pending"
  end
end
