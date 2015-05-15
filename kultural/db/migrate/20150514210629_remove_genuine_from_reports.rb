class RemoveGenuineFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :genuine, :boolean
  end
end
