class Appointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :title
      t.datetime :date
      t.text :location
      t.text :details
      t.boolean :status
      t.timestamps null: false
     end
  end
end
