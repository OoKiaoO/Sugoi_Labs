class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :action, presence: :true

end
