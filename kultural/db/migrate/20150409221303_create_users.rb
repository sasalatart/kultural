class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :mail
      t.integer :phone
      t.date :birthday
      t.boolean :male

      t.timestamps null: false
    end
  end
end
