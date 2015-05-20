class ShopsController < ApplicationController
  def show
    @boosts = Boost.subclasses.map(&:new)
  end

  def buy
    boost = params[:type].constantize.create user_id: current_user.id
    @success = boost.valid?
  end
end
