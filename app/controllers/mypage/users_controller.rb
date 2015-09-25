class Mypage::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(edit update)

  def index
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_users_path, notice: 'プロフィールを更新しました。'
    else
      render :edit
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email)
    end
end
