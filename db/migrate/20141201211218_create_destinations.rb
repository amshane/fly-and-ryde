class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long
      t.integer :user_id

      t.timestamps
    end
  end
end
