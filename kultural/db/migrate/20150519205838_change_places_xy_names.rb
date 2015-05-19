class ChangePlacesXyNames < ActiveRecord::Migration
  def change
    rename_column :places, :x, :lat
    rename_column :places, :y, :lon
  end
end
