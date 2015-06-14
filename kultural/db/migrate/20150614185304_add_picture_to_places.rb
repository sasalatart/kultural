class AddPictureToPlaces < ActiveRecord::Migration
  def self.up
    add_attachment :places, :picture
  end

  def self.down
    remove_attachment :places, :picture
  end
end
