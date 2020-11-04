class DefaultEmailListFalse < ActiveRecord::Migration[6.0]
  def change
    change_column_default :emaillists, :default, from: true, to: false
  end
end
