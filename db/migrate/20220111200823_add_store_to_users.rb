class AddStoreToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :store, null: true, foreign_key: true
  end
end
