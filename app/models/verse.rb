class Verse < ApplicationRecord
  belongs_to :chapter
  has_one :book, through: :chapter
  
  validates :number, presence: true
  validates :number, uniqueness: { scope: :chapter_id }
  validates :text, presence: true
  
  scope :ordered, -> { order(:number) }
end
