require 'fast-aes'
require 'base64'

class UrlEncoder

  DELIMETER = "-|-"

  def initialize(user)
    @user = user
  end

  def encode(*data)
    encrypted = algorithm.encrypt(with_salt(data).join(DELIMETER))
    Base64.urlsafe_encode64(encrypted)
  end

  def decode(hash)
    data = algorithm.decrypt(Base64.urlsafe_decode64(hash)).split(DELIMETER)
    return nil unless salt.has?(data.last)
    without_salt(data)
  rescue ArgumentError
    nil
  end

  private

  def salt
    @salt ||= Salt.new(@user)
  end

  def algorithm
    FastAES.new(Settings[:url][:secret])
  end

  def with_salt(data)
    data << salt.generate
  end

  def without_salt(data)
    data[0..-2]
  end

end
