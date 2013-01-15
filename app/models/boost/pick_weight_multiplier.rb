class Boost::PickWeightMultiplier < Boost
  field :factor, type: Float

  def apply!(object, field)
    current_value = object.public_send field

    object.update_attributes field => current_value * factor
  end

  def discard!(object, field)
    current_value = object.public_send field

    object.update_attributes field => current_value / factor
  end
end
