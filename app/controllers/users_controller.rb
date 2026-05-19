class UsersController < ApplicationController
  def show
    @user = current_user
    @quests = @user.quests.order(created_at: :desc)
  end
end
