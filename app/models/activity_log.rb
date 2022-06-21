class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :items

end
