class CreateEventTypes < ActiveRecord::Migration
  def change
    #drop_table :event_types
    create_table :event_types do |t|
      t.string :name
      t.text :examples

      t.timestamps null: false
    end
  end
end
