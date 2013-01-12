class User
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :photo, PhotoUploader

  field :vk_id,       type: Integer
  field :first_name,  type: String
  field :last_name,   type: String
  field :nickname,    type: String
  field :screen_name, type: String
  field :sex,         type: String
  field :bdate,       type: Date
  field :city,        type: String
  field :country,     type: String
  field :rating,      type: Integer
  field :multiplier,  type: Integer

  validates :vk_id, presence: true

  validates :vk_id, uniqueness: true
  validates :sex, inclusion: {in: %w(male female)}

  has_many :wins,  class_name: "User", inverse_of: :winner
  has_many :loses, class_name: "User", inverse_of: :loser
  has_many :plays, class_name: "User", inverse_of: :player

  scope :random, ->(num=1) {User.skip(rand(0...User.count)).limit(num) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def win!
    self.update("$inc" => { rating: self.user.multiplier * Settings[:rating][:win]  })
  end

  def lose!
    self.update("$dec" => { rating: self.user.multiplier * Settings[:rating][:lose]  })
  end
end
