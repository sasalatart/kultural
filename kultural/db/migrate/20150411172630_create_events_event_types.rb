class CreateEventsEventTypes < ActiveRecord::Migration
  def change
    create_table :events_event_types, id: false do |t|
      t.belongs_to :event, index: true, foreign_key: true
      t.belongs_to :event_type, index: true, foreign_key: true
    end
  end
end
