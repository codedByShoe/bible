class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  has_many :verses, through: :chapters

  validates :name, presence: true
  validates :order_number, presence: true, uniqueness: true

  scope :ordered, -> { order(:order_number) }
end
