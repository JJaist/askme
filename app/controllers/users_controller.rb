class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :nickname, :email, :password)

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = user.id

      redirect_to root_path, notice: 'Вы успешно зарегистрировались!'
    else
      flash.now[:alert] = 'Не верно заполнены поля регистрации'

      render :new
    end
  end
end
