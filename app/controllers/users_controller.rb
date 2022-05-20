class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Вы успешно зарегистрировались!'
    else
      flash.now[:alert] = 'Не верно заполнены поля регистрации'

      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)

      redirect_to root_path, notice: 'Данные пользователя обновлены'
    else
      flash.now[:alert] = 'Возникла ошибка при попытке сохранения'

      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    @question = Question.new(user: @user)
  end

  private

  def user_params
  params.require(:user).permit(
        :name, :nickname, :email, :header_color, :password, :password_confirmation
  )
  end
end
