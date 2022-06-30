class Item < ApplicationRecord
  has_many :item_amounts, dependent: :destroy
  has_many :activity_logs

  CATEGORIES = ['snacks', 'candies', 'chips', 'chocolates', 'soft drinks', 'seasonings', 'sauces', 'noodles']

  validates :name, presence: true
  validates :brand, presence: true
  validates :barcode, presence: true, numericality: true, length: { is: 13 }, uniqueness: true
  validates :secondary_barcode,
            allow_blank: true, 
            numericality: true, 
            length: { is: 13 }, 
            uniqueness: true, 
            :if => :secondary_barcode?
  validates :category, presence: true, :inclusion => { :in => CATEGORIES }

  include PgSearch::Model
  pg_search_scope :search_by_all_item_info,
    against: [ :name, :brand, :barcode ],
    using: {
      tsearch: { prefix: true }
    }
end
