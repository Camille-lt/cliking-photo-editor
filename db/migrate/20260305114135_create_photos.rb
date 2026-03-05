class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.integer :brightness
      t.integer :contrast
      t.integer :saturation

      t.timestamps
    end
  end
end
