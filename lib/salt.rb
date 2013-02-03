class Salt

  EXPIRE = 60*60 # 1 hour
  HEX_SIZE = 8

  def initialize(user)
    @user = user
  end

  def generate
    salt = SecureRandom.hex(HEX_SIZE)
    store(salt)
    salt
  end

  def has?(salt)
    return false unless RedisClient.sismember(key, salt)
    RedisClient.srem(key, salt)
  end

  private

  def store(salt)
    RedisClient.sadd(key, salt)
    RedisClient.expire(key, EXPIRE)
  end

  def key
    "users[#{@user.id}][salt]"
  end

end
