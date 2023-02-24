class UsersController < ApplicationController

  def show
    @user = current_user
    # use item page css & layout style to display user"s info
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email)
  end
end
