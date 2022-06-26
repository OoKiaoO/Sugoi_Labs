class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def log(item, action)
    @log = ActivityLog.new
    @log.user = current_user
    @log.item_id = item
    @log.action = action
    @log.save!
  end
end
