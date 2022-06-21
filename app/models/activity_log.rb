class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :items
  belongs_to :item_amount
end
