class GameController < ApplicationController

  def index
    @pairs = UserQueue.start_pairs
  end

  def update
    Pick.create(winner_id: params[:winner_id],
                loser_id: params[:looser_id],
                player_id: current_user.id)
  end

  def pair
    user1, user2 = UserQueue.next_pair
    render partial: 'pair', locals: {user1: user1, user2: user2}
  end

end
