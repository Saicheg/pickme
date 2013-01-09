module Vk
  class UserFetcher

    FIELDS=[:uid, :first_name, :last_name, :nickname, :screen_name, :sex, :bdate, :city, :country]

    def initialize(id, token)
      @id, @token = id, token
    end

    def user_info
      params = client.users.get(uid: @id, fields: FIELDS).first
      ParamsNormalizer.new(params, @token).normalize
    end

    private

    def client
      @vk_client ||= VkontakteApi::Client.new(@token)
    end
  end
end
