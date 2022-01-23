class AddUserToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :creator, references: :users, index: true
    add_foreign_key :products, :users, column: :creator_id

    add_reference :products, :editor, references: :users, index: true
    add_foreign_key :products, :users, column: :editor_id
  end
end
