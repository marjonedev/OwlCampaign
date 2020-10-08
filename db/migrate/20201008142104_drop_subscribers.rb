class DropSubscribers < ActiveRecord::Migration[6.0]
  def up
    drop_table :subscribers
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
