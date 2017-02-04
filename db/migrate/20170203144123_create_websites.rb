class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      # website url
      t.string :url, null: false

      t.timestamps
    end
  end
end
