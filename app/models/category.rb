class Category < ApplicationRecord
  has_one_attached :photo
  has_many :products, dependent: :restrict_with_exception
end
