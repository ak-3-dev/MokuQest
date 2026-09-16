class GroupRequestsController < ApplicationController
  before_action :set_group

  def create
    @group_request = current_user.group_requests.build(
      group: @group
    )

    if @group_request.save
      redirect_to group_path(@group), notice: "参加申請を送りました。"
    else
      redirect_to group_path(@group),
                  alert: @group_request.errors.full_messages.to_sentence
    end
  end

  def index
    unless current_user == @group.user
      redirect_to groups_path, alert: "権限がありません。"
      return
    end

    @group_requests = @group.group_requests.pending
  end

  def update
    unless current_user == @group.user
      redirect_to groups_path, alert: "権限がありません。"
      return
    end

    @group_request = @group.group_requests.find(params[:id])

    @group_request.update(status: params[:status])

    redirect_to group_group_requests_path(@group),
                notice: "更新しました。"
  end

  def destroy
    if current_user == @group.user
      redirect_to group_path(@group),
                  alert: "管理者は退会できません。"
      return
    end

    @group_request = current_user.group_requests.find_by!(
      group: @group,
      status: :approved
    )

    @group_request.destroy

    redirect_to group_path(@group),
                notice: "グループを退会しました。"
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
