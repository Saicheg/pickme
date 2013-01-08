module Vk
  class UserFetcher

    FIELDS= [:uid, :first_name, :last_name, :nickname, :screen_name, :sex, :bdate, :city, :country, :timezone]

    def initialize(params)
      @params = params
    end

    def user_info
      @vk_client.users.get(uid: @params[:watcher_id], fields: FIELDS)
    end

    def client
      @vk_client ||= VkontakteApi::Client.new(@params[:access_token])
    end
  end
end
