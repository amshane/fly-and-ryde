class AddColumnsToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :area_id, :integer
  end
end
