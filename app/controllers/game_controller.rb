class GameController < ApplicationController

  def index
    @pairs = UserQueue.start_pairs
  end

  def pair
    user1, user2 = UserQueue.next_pair
    render partial: 'pair', locals: {user1: user1, user2: user2}
  end

end
