class ChangeFrom < ActiveRecord::Migration[6.0]
  def change
    rename_column :campaigns, :from, :from_name
    add_column :campaigns, :from_email, :string
  end
end
