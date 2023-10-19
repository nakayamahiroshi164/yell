class WeightlossesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
 
  def index
    @weightlosses = Weightloss.all
  end

  def new
    @weightloss = Weightloss.new
  end

  def create
    @user = current_user
    @weightloss = Weightloss.new(weightloss_params)
    @weightloss.user = @user

    if @weightloss.save
      redirect_to weightlosses_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @weightloss = Weightloss.find(params[:id])
    @comment = Comment.new
    @comments = @weightloss.comments.includes(:user)
  end

  def edit
    @weightloss = Weightloss.find(params[:id])
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def update
    @weightloss = Weightloss.find(params[:id])
    if @weightloss.update(weightloss_params)
      redirect_to weightloss_path(@weightloss)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weightloss = weightloss.find(params[:id])
    @weightloss.destroy
    redirect_to '/'
  end

  
  private  
  def weightloss_params  
    params.require(:weightloss).permit(:weight, :sleep, :faigue, :exercise, :meal).merge(user_id: current_user.id)
  end
end

