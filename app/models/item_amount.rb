class ItemAmount < ApplicationRecord
  belongs_to :item

  validates :amount, presence: true, numericality: true
  validates :exp_date, presence: true
end
