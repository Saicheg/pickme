class User
  include Mongoid::Document

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

  validates :vk_id, presence: true

  validates :vk_id, uniqueness: true
  validates :sex, inclusion: {in: %w(male female)}

  def full_name
    "#{first_name} #{last_name}"
  end
end
