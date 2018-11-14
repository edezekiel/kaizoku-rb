class CreateToolkits < ActiveRecord::Migration[5.0]
  def change
    create_table :toolkit do |t|
      t.belongs_to :subcategory, index: true
      t.string :name
      t.string :description
      t.string :github
      t.integer :rating
      t.integer :subcategory_id
      t.timestamps
    end
  end
end
