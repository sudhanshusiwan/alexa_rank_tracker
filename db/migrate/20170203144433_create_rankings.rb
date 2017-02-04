class CreateRankings < ActiveRecord::Migration[5.0]
  def change
    create_table :rankings do |t|
      t.integer :website_id

      # alexa global rank
      t.integer :alexa_global_rank

      t.timestamps
    end

    add_index :rankings, :website_id
  end
end
