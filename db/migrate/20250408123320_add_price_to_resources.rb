class AddPriceToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :price, :integer
  end
end
