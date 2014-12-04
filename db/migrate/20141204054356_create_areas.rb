class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :borough
      t.string :neighborhood

      t.timestamps
    end
  end
end
