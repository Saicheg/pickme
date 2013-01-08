class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :validate_auth_key

  def validate_auth_key
    raise ActionController::RoutingError.new I18n.t('error.auth_key') unless auth_key_valid?
  end

  private

  def auth_key_valid?
    key_string = "#{params[:api_id]}_#{params[:viewer_id]}_#{Settings[:api_secret]}"
    params[:auth_key] == Digest::MD5.hexdigest(key_string)
  end
end
