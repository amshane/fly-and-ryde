class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :driver_name
      t.float :price
      t.string :uber_confirmation

      t.timestamps
    end
  end
end
