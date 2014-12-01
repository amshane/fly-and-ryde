class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.integer :airport_id
      t.integer :user_id
      t.integer :destination_id
      t.integer :ride_id
      t.boolean :complete
      t.datetime :arrival_time

      t.timestamps
    end
  end
end
