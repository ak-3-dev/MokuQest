class CommentsController < ApplicationController
  def create
    @quest = Quest.find(params[:quest_id])
    @comment = @quest.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to quest_path(@quest), notice: "コメントを投稿しました!"
    else
      redirect_to quest_path(@quest), alert: "コメントの投稿に失敗しました"
    end
  end
  
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to @comment.quest, notice: "コメントを取り消しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
