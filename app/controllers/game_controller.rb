class GameController < ApplicationController

  before_filter :url_encoder

  def index
    @pairs = UserQueue.start_pairs
  end

  def pair
    @user_left, @user_right = UserQueue.next_pair
    respond_to do |format|
      format.json
      format.html do
        render partial: 'pair', locals: {user_left: @user_left, user_right: @user_right, url_encoder: @url_encoder}
      end
    end
  end

  private

  def url_encoder
    @url_encoder ||= UrlEncoder.new(current_user)
  end

end
