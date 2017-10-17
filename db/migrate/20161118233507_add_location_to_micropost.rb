class AddLocationToMicropost < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :locations, :locations
  end
end
