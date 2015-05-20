class Pick
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :winner, class_name: 'User', inverse_of: :picks
  belongs_to :loser,  class_name: 'User', inverse_of: :loses
  belongs_to :player, class_name: 'User', inverse_of: :plays

  field :guid, type: String

  validates :guid, uniqueness: true
  validates :guid, presence:   true

  before_validation :generate_guid
  after_create :update_ratings

  private

  def generate_guid
    self.guid = Digest::SHA256.hexdigest([Time.now.beginning_of_hour, self.player_id, self.winner_id, self.loser_id ].join)
  end

  def update_ratings
    self.winner.win!
    self.loser.lose!
  end

end
