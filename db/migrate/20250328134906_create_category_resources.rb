class CreateCategoryResources < ActiveRecord::Migration[8.0]
  def change
    create_table :categories_resources do |t|
      t.belongs_to :category
      t.belongs_to :resource
    end

    add_index :categories_resources, [ :category_id, :resource_id ], unique: true
  end
end
