class Appointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :title
      t.string :date
      t.text :location
      t.text :details
      t.boolean :status
      t.integer :user_id
      t.timestamps null: false
     end
  end
end
