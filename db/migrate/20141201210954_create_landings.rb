class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.integer :airport_id
      t.integer :user_id
      t.integer :destination_id
      t.integer :ride_id
      t.time :arrival_time
      t.boolean :complete, :default => false


      t.timestamps
    end
  end
end
