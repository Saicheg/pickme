class Pick
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :winner, class_name: 'User', inverse_of: :picks
  belongs_to :loser,  class_name: 'User', inverse_of: :loses
  belongs_to :player, class_name: 'User', inverse_of: :plays

  after_create :update_ratings

  private

  def update_ratings
    self.winner.win!
    self.loser.lose!
  end

end
