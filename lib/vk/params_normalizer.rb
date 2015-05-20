module Vk
  class ParamsNormalizer
    # Check fields info here:
    # http://vk.com/developers.php?oid=-1&p=%D0%9E%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5_%D0%BF%D0%BE%D0%BB%D0%B5%D0%B9_%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80%D0%B0_fields

    PARAMS = %w(vk_id first_name last_name nickname screen_name sex bdate city country)

    def initialize(params, token)
      @params, @token = params, token
    end

    %w(first_name last_name nickname screen_name).each do |type|
      define_method(type.to_sym) { @params[type.to_sym] }
    end

    def sex
      @params[:sex] == 1 ? "female" : "male"
    end

    def vk_id
      @params[:uid]
    end

    def bdate
      date = @params[:bdate]
      DateTime.strptime(date, "%d.%m.%Y")
    end

    #TODO: cache cities and countries in YAML file
    def country
      client.places.get_countries.select{|hash| hash["cid"] == @params[:country].to_i}.first[:title]
    end

    def city
      client.places.get_cities(country: @params[:country]).select{|hash| hash["cid"] == @params[:city].to_i}.first[:title]
    end

    def normalize
      PARAMS.each_with_object({}) {|param, hash| hash[param.to_sym] = send(param.to_sym) }
    end

    private

    def client
      @vk_client ||= VkontakteApi::Client.new(@token)
    end

  end
end
