class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hourly_pay, :integer
  end
end
