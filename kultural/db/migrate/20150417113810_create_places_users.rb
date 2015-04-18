class CreatePlacesUsers < ActiveRecord::Migration
  def change
    create_table :places_users, id: false do |t|
      t.belongs_to :place, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
