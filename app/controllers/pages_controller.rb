class PagesController < ApplicationController
  def intro
    redirect_to user_path(current_user) if current_user.photo?
  end
end
