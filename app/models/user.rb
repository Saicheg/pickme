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

  field :rating,      type: Float,   default: Settings[:rating][:start]
  field :multiplier,  type: Float,   default: Settings[:multiplier][:default]

  validates :vk_id, presence: true

  validates :vk_id, uniqueness: true

  validates :sex, inclusion: { in: %w(male female) }

  has_many :wins,  class_name: 'Pick', inverse_of: :winner
  has_many :loses, class_name: 'Pick', inverse_of: :loser
  has_many :plays, class_name: 'Pick', inverse_of: :player

  has_many :boosts

  has_one :setting

  scope :random, ->(num = 1) { User.skip(rand(0...User.count)).limit(num) }

  after_create :create_setting

  def full_name
    "#{first_name} #{last_name}"
  end

  def win!
    self.inc(:rating, self.multiplier * Settings[:rating][:win])
  end

  def lose!
    self.inc(:rating, self.multiplier * Settings[:rating][:lose])
  end
end
