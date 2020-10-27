class AddDefaultAdmin < ActiveRecord::Migration[6.0]
  def up
    change_column_default :users, :admin, 1
  end

  def down
    change_column_default :users, :admin, nil
  end
end
