class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.integer :user_id
      t.timestamps
    end

    add_index :admins, :user_id, unique: true
  end
end
