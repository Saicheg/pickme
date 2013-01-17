class PicksController < ApplicationController
  before_filter :decode_params, only: :create

  def create
    Pick.create(winner_id: params[:winner_id],
                loser_id: params[:looser_id],
                player_id: current_user.id)
  end

  private

  def decode_params
    winner_id, loser_id = UrlEncode.decode(params[:uuid])
    raise ActiveRecord::RecordNotFound unless winner_id || loser_id
  end
end
