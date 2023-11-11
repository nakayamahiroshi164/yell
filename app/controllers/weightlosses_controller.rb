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
    @weightloss = Weightloss.find_by(user_id: @user.id, created_at: Date.today.beginning_of_day..Date.today.end_of_day)
    if @weightloss
      redirect_to weightlosses_path, alert: "本日は既に投稿されています。"
      return
    end

    @weightloss = Weightloss.new(weightloss_params)
    @weightloss.user = @user

    unless valid_weight?(@weightloss.weight)
      @weightloss.errors.add(:weight, "は正しい形式で入力してください。")
      render :new, status: :unprocessable_entity
      return
    end

    if @weightloss.save
      redirect_to weightlosses_path, notice: '投稿が保存されました。'
    else
      if params[:user].present? && params[:user][:email].present? && params[:user][:password].present?
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
          redirect_to weightlosses_path(@user), notice: 'ログインしました'
        else
          if params[:user][:email].blank?
            flash.now[:alert] = 'メールアドレスを入力してください'
          elsif params[:user][:password].blank?
            flash.now[:alert] = 'パスワードを入力してください'
          else
            flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません'
          end
          render :new, status: :unprocessable_entity
        end
      else
        flash.now[:alert] = 'メールアドレスとパスワードを入力してください'
        render :new, status: :unprocessable_entity
      end
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

  def valid_weight?(weight)
    /\A\d+(\.\d{1})?\z/.match?(weight.to_s)
  end

  def weightloss_params
    params.require(:weightloss).permit(:weight, :faigue, :exercise, :meal, :sleep).merge(user_id: current_user.id)
  end

end
