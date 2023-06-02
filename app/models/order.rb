class Order < ApplicationRecord
  belongs_to :user
  has_many :carts, dependent: :destroy
  validates :phone_number, presence: true, length: { is: 8 }
  validate :validate_name_presence
  def validate_name_presence
    if name.blank? || name.split.size < 2
      errors.add(:name, 'Debe ingresar al menos un nombre y un apellido')
    end
  end
end
