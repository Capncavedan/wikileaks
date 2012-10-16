class CreateLeaks < ActiveRecord::Migration
  def change
    create_table :leaks do |t|
      t.datetime :cable_date
      t.string :origin_id
      t.string :origin_description
      t.string :classification
      t.string :destination_id
      t.string :header, limit: 4096
      t.text :body

      t.timestamps
    end
  end
end
