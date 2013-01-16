class Boosts::PickWeightMultiplier < Boost
  field :multiplier, type: Float

  def apply!(object)
    object.update_attributes multiplier: multiplier
  end

  def discard!(object)
    object.update_attributes multiplier: 1
  end
end
