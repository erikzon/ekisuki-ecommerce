class Product < ApplicationRecord
  has_many_attached :photos
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  belongs_to :category
end
