class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  before_filter :validate_auth_key

  def current_user
    @current_user ||= login_from_session || login_from_params
  end

  def logged_in?
    !!current_user
  end

  def validate_auth_key
    raise ActionController::RoutingError.new I18n.t('error.auth_key') unless auth_key_valid?
  end

  private

  def login_from_session
    User.find(session[:user]) if session[:user]
  end

  def login_from_params
    user = User.find_by(vk_id: params[:viewer_id])
    user ||= create_user
  end

  # TODO: fetch other info
  def create_user
    user = User.create(Vk::UserFetcher.new(params).user_info)
    session[:user] = user.id
    user
  end

  def auth_key_valid?
    key_string = "#{params[:api_id]}_#{params[:viewer_id]}_#{Settings[:api_secret]}"
    params[:auth_key] == Digest::MD5.hexdigest(key_string)
  end
end
