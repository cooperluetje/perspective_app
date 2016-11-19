class AddLocationToMicropost < ActiveRecord::Migration[5.0]
  def change
    add_column :microposts, :location, :location
  end
end
