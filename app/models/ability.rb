class Ability
  include CanCan::Ability

  def initialize(user)
    can :activate, Boost, user_id: user.id
  end
end
