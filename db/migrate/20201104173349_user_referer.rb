class UserReferer < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :referer, :string
  end
end
