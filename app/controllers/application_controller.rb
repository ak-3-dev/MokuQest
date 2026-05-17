class ApplicationController < ActionController::Base
  # ログイン・新規登録など、deviseの機能が動く前に実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 新規登録（sign_up）の際に、nameカラムのデータも許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end