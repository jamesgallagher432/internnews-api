class AddParentToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :parent, null: true, foreign_key: false
  end
end
