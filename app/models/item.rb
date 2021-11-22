class Item < ApplicationRecord
  has_many :item_amounts

  validates :name, presence: true
  validates :brand, presence: true
  validates :barcode, presence: true, numericality: true, length: { is: 13 }
end
