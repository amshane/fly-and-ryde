class AddColumnsToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :neighborhood, :string
    add_column :destinations, :borough, :string
  end
end
