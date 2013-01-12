class UserQueue

  # TODO: we need some smart queue with preselecting users and filtering by area and sex
  def self.next_pair
    User.random(2).to_a
  end

end
