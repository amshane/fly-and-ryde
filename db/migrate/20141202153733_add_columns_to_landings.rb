class AddColumnsToLandings < ActiveRecord::Migration
  def change
    add_column :landings, :airline, :string
    add_column :landings, :flight_num, :string
    add_column :landings, :arrival_date, :date
  end
end
