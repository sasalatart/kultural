class CreateComments < ActiveRecord::Migration
  def change
    #drop_table :comments
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps null: false
    end
  end
end
