class CommentsController < ApplicationController
  def create
    @weightloss = Weightloss.find(params[:weightloss_id])
    @comment = Comment.create(comment_params)
    @comment.user = current_user
    @comment.weightloss = @weightloss
    
    if @comment.save
      redirect_to weightloss_path(@comment.weightloss) 
    else
      @weightloss = @comment.weightloss
      
      render "weightlosses/show" 
   end
  end
  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, weightloss_id: params[:weightloss_id])
  end
end
