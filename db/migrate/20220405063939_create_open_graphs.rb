class CreateOpenGraphs < ActiveRecord::Migration[6.1]
  def change
    create_table :open_graphs do |t|
      t.string :url
      t.jsonb :og_data, null: false, default: '{}'

      t.timestamps
    end
  end
end
