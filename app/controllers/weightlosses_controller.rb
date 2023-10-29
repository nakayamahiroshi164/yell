class WeightlossesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
 
  def index
    if params[:user_id].present?
      @user = User.find_by(id: params[:user_id])
      @weightlosses = @user&.weightlosses
    else
      @weightlosses = Weightloss.all
    end

    @users = User.all
  end


  def new
    @weightloss = Weightloss.new
  end

  def create
    @user = current_user
    @weightloss = Weightloss.new(weightloss_params)
    @weightloss.user = @user

    if @weightloss.save
      redirect_to weightlosses_path(user_id: @user.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @weightloss = Weightloss.find(params[:id])
    @comment = Comment.new
    @comments = @weightloss.comments.includes(:user)

    unless user_signed_in?
      redirect_to weightlosses_path, alert: "ログインしてください。"
    end
  end


  def edit
    @weightloss = Weightloss.find(params[:id])
    unless @weightloss.user == current_user
      redirect_to action: :index, alert: "権限がありません。"
    end
  end

  def update
    @weightloss = Weightloss.find(params[:id])
    unless @weightloss.user == current_user
      redirect_to action: :index, alert: "権限がありません。"
      return
    end

    if @weightloss.update(weightloss_params)
      redirect_to weightloss_path(@weightloss)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weightloss = Weightloss.find(params[:id])
    unless @weightloss.user == current_user
      redirect_to action: :index, alert: "権限がありません。"
      return
    end

    @weightloss.destroy
    redirect_to '/'
  end

  private  
  def weightloss_params  
    params.require(:weightloss).permit(:weight, :sleep, :faigue, :exercise, :meal).merge(user_id: current_user.id)
  end
end