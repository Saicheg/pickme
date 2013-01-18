require 'fast-aes'
require 'base64'

class UrlEncoder
class << self

  DELIMETER = "-|-"

  def encode(*data)
    encrypted = algorithm.encrypt(with_salt(data).join(DELIMETER))
    Base64.urlsafe_encode64(encrypted)
  end

  def decode(hash)
    data = algorithm.decrypt(Base64.urlsafe_decode64(hash)).split(DELIMETER)
    return nil unless data.include?(Settings[:url][:salt])
    without_salt(data)
  rescue ArgumentError
    nil
  end

  private

  def algorithm
    FastAES.new(Settings[:url][:secret])
  end

  def with_salt(data)
    data << Settings[:url][:salt]
  end

  def without_salt(data)
    data[0..-2]
  end

end
end
