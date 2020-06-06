class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :link, null: false, foreign_key: true
      t.string :description
      t.references :parent, index: true, foreign_key: { to_table: :comments }
      t.references :kids, index: true, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
