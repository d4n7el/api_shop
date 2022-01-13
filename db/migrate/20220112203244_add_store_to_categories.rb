class AddStoreToCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :store, null: false, foreign_key: true
  end
end
