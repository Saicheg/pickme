class UsersController < ApplicationController

  def index
    @users = User.order_by(rating: :desc).limit(10)
  end

  def show
  end

  def update
    current_user.update_attributes params[:user]
    respond_with current_user
  end

end
