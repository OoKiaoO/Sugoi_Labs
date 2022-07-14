class ItemAmount < ApplicationRecord
  belongs_to :item

  validates :amount, presence: true, numericality: true
  validates :exp_date, presence: true
  validates :checked, inclusion: { in: [true, false] }
  validates :exp_amount, presence: true, if: :checked
end
