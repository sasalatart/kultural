class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.boolean :genuine

      t.belongs_to :user, index: true, foreign_key: true
      t.references :reportable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
