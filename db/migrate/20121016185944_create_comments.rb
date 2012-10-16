class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :cable_id
      t.string :body
    end
  end
end
