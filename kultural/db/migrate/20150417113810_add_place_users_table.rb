class AddPlaceUsersTable < ActiveRecord::Migration
  def change
    create_table :places_users, id: false do |t|
      t.belongs_to :place, index: true
      t.belongs_to :user, index: true
    end
  end
end
