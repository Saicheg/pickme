class GameController < ApplicationController

  before_filter :url_encoder

  def index
    @pairs = UserQueue.start_pairs
  end

  def pair
    user1, user2 = UserQueue.next_pair
    render partial: 'pair', locals: {user1: user1, user2: user2, url_encoder: url_encoder}
  end

  private

  def url_encoder
    @url_encoder ||= UrlEncoder.new(current_user)
  end

end
