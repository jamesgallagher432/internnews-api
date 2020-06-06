class AddFieldsToLink < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :title, :string
    add_column :links, :slug, :string
  end
end
