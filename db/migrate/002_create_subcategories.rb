class CreateSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_table :subcategories do |t|
      t.belongs_to :category, index: true
      t.string :name
      t.string :url
      t.integer :category_id
      t.timestamps
    end
  end
end
