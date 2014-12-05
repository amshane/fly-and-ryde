class AddCancelledToLandings < ActiveRecord::Migration
  def change
    add_column :landings, :cancelled, :boolean, :default => false
  end
end
