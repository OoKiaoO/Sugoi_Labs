class Item < ApplicationRecord
  has_many :item_amounts, dependent: :destroy

  validates :name, presence: true
  validates :brand, presence: true
  validates :barcode, presence: true, numericality: true, length: { is: 13 }

  include PgSearch::Model
  pg_search_scope :search_by_all_item_info,
    against: [ :name, :brand, :barcode ],
    using: {
      tsearch: { prefix: true }
    }
end
