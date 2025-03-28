class CreateCategoryResources < ActiveRecord::Migration[8.0]
  def change
    create_table :category_resources do |t|
      t.references :category, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
