class AddMicropostToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :micropost_id, :integer
  end
end
