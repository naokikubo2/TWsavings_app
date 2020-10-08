class CreateUndoneActions < ActiveRecord::Migration[6.0]
  def change
    create_table :undone_actions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :action_name
      t.integer :default_time

      t.timestamps
    end
  end
end
