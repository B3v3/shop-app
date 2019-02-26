class AddTagIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :tag_id, :integer
  end
end
