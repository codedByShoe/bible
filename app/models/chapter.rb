class Chapter < ApplicationRecord
  belongs_to :book
  has_many :verses, dependent: :destroy
  
  validates :number, presence: true
  validates :number, uniqueness: { scope: :book_id }
  
  scope :ordered, -> { order(:number) }
end
