class Tag < ApplicationRecord
  has_one_attached :photo
  # has_many :products, dependent: :restrict_with_exception
  has_and_belongs_to_many :products
end
