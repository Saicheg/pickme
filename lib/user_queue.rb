class UserQueue

  # TODO: we need some smart queue with preselecting users and filtering by area and sex
  def self.next_pair
    (0..1).map { User.random.first }
  end

  def self.start_pairs
    (0...Settings[:game][:start_pairs]).map{ self.next_pair }
  end

end
