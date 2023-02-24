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

  # create Users controller the usual way -> rails g ...
  # create show method with @user = curent_user
  # route: get 'users/:id' => 'users#show' or resources :users, only: [:show]
  # for edit, redirect to users/registrations edit form
end
