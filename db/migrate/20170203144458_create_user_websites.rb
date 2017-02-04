class CreateUserWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :user_websites do |t|
      t.integer :user_id, null: false
      t.integer :website_id, null: false

      t.timestamps
    end

    add_index :user_websites, :user_id
    add_index :user_websites, :website_id
  end
end
