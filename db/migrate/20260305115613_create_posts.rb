class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :caption
      t.integer :brightness
      t.integer :contrast
      t.integer :saturation
      t.string :filter_name

      t.timestamps
    end
  end
end
