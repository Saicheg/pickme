class GameController < ApplicationController

  def index
    @pairs = UserQueue.start_pairs
  end

  def update
    Pick.create(winner_id: params[:winner_id],
                loser_id: params[:looser_id],
                player_id: current_user.id)
  end

end
