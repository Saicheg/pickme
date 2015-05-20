class BoostsController < ApplicationController
  def index
    @boosts = current_user.boosts
  end

  def activate
    @boost = Boost.find params[:id]
    authorize! :activate, @boost

    @boost.apply!(current_user)
    @boost.activate
  end
end
