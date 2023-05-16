class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }
  has_many_attached :photos
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  has_many :carts, dependent: :destroy
  belongs_to :category
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

end
