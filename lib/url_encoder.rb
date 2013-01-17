require 'fast-aes'
require 'base64'

class UrlEncoder
class << self

  DELIMETER = "-|-"

  def encode(*data)
    Base64.urlsafe_encode64(algorithm.encrypt(data.join(DELIMETER)))
  end

  # TODO: handle errors
  def decode(hash)
    algorithm.decrypt(Base64.urlsafe_decode64(hash)).split(DELIMETER)
  end

  private

  def algorithm
    FastAES.new(Settings[:url_secret_key])
  end

end
end
