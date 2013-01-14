class Setting
  include Mongoid::Document

  field :pick_sex, type: String

  validates :pick_sex, inclusion: { in: %w(male female) }

  belongs_to :user
end
