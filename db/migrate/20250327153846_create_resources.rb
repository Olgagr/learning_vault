class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.text :description
      t.string :resource_type, null: false, default: "course", index: true
      t.check_constraint "resource_type in ('course', 'book', 'video', 'article', 'podcast', 'other')", name: "resource_type_check"
      t.string :progress_status, null: false, default: "unstarted", index: true
      t.check_constraint "progress_status in ('unstarted', 'in_progress', 'completed', 'abandoned')", name: "progress_status_check"
      t.string :link, null: false
      t.boolean :owned, null: false, default: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :resources, [:user_id, :name], unique: true
  end
end
