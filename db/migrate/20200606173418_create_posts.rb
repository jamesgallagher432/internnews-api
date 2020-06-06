class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :url
      t.string :text
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
