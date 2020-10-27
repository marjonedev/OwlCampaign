class AddDefaultAdmin2 < ActiveRecord::Migration[6.0]
  def up
    change_column_default :users, :admin, 0
  end

  def down
    change_column_default :users, :admin, nil
  end
end
