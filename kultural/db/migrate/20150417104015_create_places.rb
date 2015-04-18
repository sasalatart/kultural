class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :description # TODO: change view
      t.float :x
      t.float :y

      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
