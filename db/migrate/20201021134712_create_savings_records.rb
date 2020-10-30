class CreateSavingsRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :savings_records do |t|
      t.references :user, null: false, foreign_key: true

      t.integer :earned_time
      t.date :savings_date
      t.string :savings_name

      t.timestamps
    end
  end
end
