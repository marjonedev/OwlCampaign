class TemplateAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :admin_default, :boolean, default: false
  end
end
