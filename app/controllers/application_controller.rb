class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 啟動瀏覽器的安全檢查，但是 API 的請求與回應不會通過瀏覽器
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :age, :region, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :region, :age, :phone])
  end
end
