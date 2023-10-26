class WeightlossesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
 
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @weightlosses = @user.weightlosses
    else
      @weightlosses = Weightloss.all
    end

    @calendar = {} 
    start_date = Date.current.beginning_of_month
    end_date = Date.current.end_of_month

    (start_date..end_date).each do |date|
      weightloss = @weightlosses.find_by(created_at: date)
      @calendar[date] = weightloss if weightloss.present?
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
    @weightloss = Weightloss.find(params[:id])
    @weightloss.destroy
    redirect_to '/'
  end

  
  private  
  def weightloss_params  
    params.require(:weightloss).permit(:weight, :sleep, :faigue, :exercise, :meal).merge(user_id: current_user.id)
  end
end

