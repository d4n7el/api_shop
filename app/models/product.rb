class Product < ApplicationRecord
  belongs_to :category

  belongs_to :user , :foreign_key => 'creator_id'
  belongs_to :user , :foreign_key => 'editor_id'

  validates :creator_id, presence: true
  validates :editor_id, presence: true

  enum status: {active: 1 , inactive: 2}
end
