class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :rateable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
