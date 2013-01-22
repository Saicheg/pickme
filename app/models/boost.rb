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

  def inactive?
    activated_at.blank?
  end

  def active?
    activated_at.present? && !ended?
  end

  def ended?
    activated_at + duration < Time.now if activated_at
  end

  def current_state
    %w{inactive active ended}.select { |state| public_send "#{state}?" }.first
  end

  def partial_name
    self.class.to_s.demodulize.tableize.singularize
  end
end
