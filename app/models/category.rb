class Category < ApplicationRecord
  belongs_to :store
  has_many :users, through: :stores

  enum status: {active: 1 , inactive: 2}
end
