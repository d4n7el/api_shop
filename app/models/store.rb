class Store < ApplicationRecord
  has_many :users
  enum status: {active: 1 , inactive: 2}
end
