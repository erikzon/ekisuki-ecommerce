class Product < ApplicationRecord
  has_many_attached :photos
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :tags_id, presence: true

  belongs_to :category
  # has_and_belongs_to_many :tags
  has_and_belongs_to_many :tags, join_table: "products_tags", foreign_key: "product_id", association_foreign_key: "tag_id"
end
