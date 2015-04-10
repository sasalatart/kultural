class AddEventEventTypesTable < ActiveRecord::Migration
  def change
    create_table :events_event_types, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :event_type, index: true
    end
  end
end
