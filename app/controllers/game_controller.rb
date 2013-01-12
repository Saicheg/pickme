class GameController < ApplicationController

  def index
    @users = UserQueue.next_pair
  end

  def update
    Pick.create(user_id: params[:user_id],
                opponent_id: params[:opponent_id],
                player_id: current_user.id)
  end

end
