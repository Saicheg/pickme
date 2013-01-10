class UsersController < ApplicationController
  before_filter :init_user

  def show

  end

  def update
    @user.update_attributes params[:user]

    respond_with @user
  end

  private
  def init_user
    @user = current_user
  end
end
