class DefaultEmailList < ActiveRecord::Migration[6.0]
  def change
    add_column :emaillists, :default, :boolean, default: true
  end
end
