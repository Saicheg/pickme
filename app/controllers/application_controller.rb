class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  helper_method :current_user, :logged_in?

 before_filter :validate_auth_key
 before_filter :logged_in?

  def current_user
    @current_user ||= login_from_session || login_from_params
  end

  def logged_in?
    !!current_user
  end

  def validate_auth_key
    raise ActionController::RoutingError.new I18n.t('error.auth_key') unless signed_in? || auth_key_valid?
  end

  private
  def signed_in?
    session[:user_id]
  end

  def login_from_session
    User.find(session[:user_id]) if session[:user_id]
  end

  def login_from_params
    user = User.find_by(vk_id: params[:viewer_id])
    user ||= create_user
  end

  def create_user
    user = User.create(Vk::UserFetcher.new(params[:watcher_id], params[:access_token]).user_info)
    session[:user_id] = user.id
    user
  end

  def auth_key_valid?
    key_string = "#{params[:api_id]}_#{params[:viewer_id]}_#{Settings[:api_secret]}"
    params[:auth_key] == Digest::MD5.hexdigest(key_string)
  end
end
