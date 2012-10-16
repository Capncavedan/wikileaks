class RenameLeaksToCables < ActiveRecord::Migration
  def up
    rename_table :leaks, :cables
  end

  def down
    rename_table :cables, :leaks
  end
end
