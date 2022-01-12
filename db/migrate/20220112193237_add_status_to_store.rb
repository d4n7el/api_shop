class AddStatusToStore < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :status, :integer, default: 1
  end
end
