class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def log(item, action, item_amount=nil, exp_date=nil)
    @log = ActivityLog.new
    @log.user = current_user
    @log.item_id = item
    @log.action = action
    @log.item_amount = item_amount
    @log.item_amount_exp_date = exp_date
    @log.save!
  end

  def user
    @username = current_user.username
    @email = current_user.email
  end
end
