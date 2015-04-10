class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.float :price
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
