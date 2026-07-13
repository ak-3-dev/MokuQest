class GroupsController < ApplicationController
  def index
    @groups = Group.search(params[:keyword]).order(created_at: :desc)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      @group.group_requests.create!(
        user: current_user,
        status: :approved
      )
      
      redirect_to groups_path, notice: "グループを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])

    @group.destroy

    redirect_to groups_path,
                notice: "グループを削除しました。"
  end

  private

  def group_params
    params.require(:group).permit(
      :name,
      :description,
      :rules
    )
  end
end