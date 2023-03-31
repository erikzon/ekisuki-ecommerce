class Tag < ApplicationRecord
  has_one_attached :photo
  has_many :taggings, dependent: :destroy
  has_many :products, through: :taggings
end
