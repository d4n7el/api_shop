class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.references :user, null: false, foreign_key: true, default: 1
      t.integer :status

      t.timestamps
    end
  end
end
