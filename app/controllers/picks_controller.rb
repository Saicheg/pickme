class PicksController < ApplicationController
  before_filter :decode_params, only: :create

  def create
    Pick.create(winner_id: @winner_id,
                loser_id:  @loser_id,
                player_id: current_user.id)
    render nothing: true, status: :ok
  end

  private

  def decode_params
    @winner_id, @loser_id = UrlEncoder.new(current_user).decode(params[:uuid])
    raise ActiveRecord::RecordNotFound unless @winner_id || @loser_id
  end
end
