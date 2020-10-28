class AddColumnTemplateVisible < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :visible, :boolean, default: true
  end
end
