class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
  if resource.is_a?(Admin)
    admin_users_path 
  else
    user_path(current_user) 
  end
end

  def after_sign_out_path_for(resource)
    about_path
  end

  def after_update_path_for(resource)
    latest_quest = resource.quests.order(created_at: :desc).first

    if latest_quest
      quest_path(latest_quest)
    else
      user_path(resource)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password])
  end

end