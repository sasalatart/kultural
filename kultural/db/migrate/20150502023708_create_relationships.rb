class CreateRelationships < ActiveRecord::Migration
  def change
    # There is a problem at deleting if id is not present :(
    create_table :relationships do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps null: false
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true

    add_foreign_key :relationships, :users, column: :follower_id, primary_key: :id
    add_foreign_key :relationships, :users, column: :followed_id, primary_key: :id
  end
end
