class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    latest_quest = resource.quests.order(created_at: :desc).first

    if latest_quest
      quest_path(latest_quest)
    else
      user_path(resource)
    end
  end
end