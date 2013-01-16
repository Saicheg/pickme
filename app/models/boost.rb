class Boost
  include Mongoid::Document

  field :activated_at,      type: DateTime
  field :duration,          type: Integer

  field :name,             type: String

  belongs_to :user

  scope :activated, -> { where :activated_at.exists => true }
  scope :available, -> { where activated_at: nil }

  def apply!(object)
    raise NotImplementedError, I18n.t('errors.not_implemented', method: :apply!)
  end

  def discard!(object)
    raise NotImplementedError, I18n.t('errors.not_implemented', method: :discard!)
  end

  def activate
    update_attributes activated_at: Time.now
  end
end
