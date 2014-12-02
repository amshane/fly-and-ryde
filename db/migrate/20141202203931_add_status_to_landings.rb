class AddStatusToLandings < ActiveRecord::Migration
  def change
    add_column :landings, :status, :string, :default => "available"
  end
end
